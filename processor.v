/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

    wire stall, branch_or_jump_taken; // Early declaration needed for stalling, branch flushing

    // PC, FD latch
    wire [31:0] pc_curr, pc_next_def, pc_next, fd_pc_out, fd_ir_out;
    assign address_imem = pc_curr;
    pc_reg pc(clock, reset, ~stall, pc_next, pc_curr);
    cla_full_adder inc_pc(pc_curr, 32'b1, 1'b0, pc_curr | 32'b1, pc_curr & 32'b1, pc_next_def);
    // since FD latch is positive clk and ins memory needs a cycle to get ins, pass in pc_curr to actually latch pc + 1
    fd_latch fd(clock, ~stall, pc_curr, branch_or_jump_taken ? 32'b0 : q_imem, fd_pc_out, fd_ir_out);

    // Regfile assignments
    wire [4:0] fd_opcode;
    assign fd_opcode = fd_ir_out[31:27];
    wire fd_is_r_type_op, fd_is_bex_op;
    assign fd_is_r_type_op = ~fd_opcode[4] & ~fd_opcode[3] & ~fd_opcode[2] & ~fd_opcode[1] & ~fd_opcode[0];
    assign fd_is_bex_op = fd_opcode[4] & ~fd_opcode[3] & fd_opcode[2] & fd_opcode[1] & ~fd_opcode[0];

    assign ctrl_readRegA = fd_ir_out[21:17];
    assign ctrl_readRegB = fd_is_r_type_op ? fd_ir_out[16:12] : (fd_is_bex_op ? 5'd30 : fd_ir_out[26:22]);

    // DX latch
    wire [31:0] dx_ir_in, dx_pc_out, dx_a_out, dx_b_out, dx_ir_out;
    assign dx_ir_in = stall ? 32'b0 : fd_ir_out;
    dx_latch dx(clock, fd_pc_out, data_readRegA, data_readRegB, branch_or_jump_taken ? 32'b0 : dx_ir_in, dx_pc_out, dx_a_out, dx_b_out, dx_ir_out);

    // ALU
    wire [31:0] sx_imm;
    assign sx_imm[16:0] = dx_ir_out[16:0];
    assign sx_imm[31:17] = dx_ir_out[16] ? 15'b111111111111111 : 15'b0;

    wire [4:0] dx_opcode;
    assign dx_opcode = dx_ir_out[31:27];
    wire [31:0] alu_in_a, alu_in_b;
    
    // Early declarations of these wires needed for bypassing
    wire [1:0] mux_a_select, mux_b_select;
    wire [31:0] xm_o_out;
    
    mux_4 alu_a_mux(alu_in_a, mux_a_select, xm_o_out, data_writeReg, dx_a_out, 32'b0);
    wire [31:0] alu_b_mux_out;
    mux_4 alu_b_mux(alu_b_mux_out, mux_b_select, xm_o_out, data_writeReg, dx_b_out, 32'b0);

    wire dx_is_r_type_op, dx_is_branch_op;
    assign dx_is_r_type_op = ~dx_opcode[4] & ~dx_opcode[3] & ~dx_opcode[2] & ~dx_opcode[1] & ~dx_opcode[0];
    assign dx_is_branch_op = (~dx_opcode[4] & ~dx_opcode[3] & ~dx_opcode[2] & dx_opcode[1] & ~dx_opcode[0]) | 
        (~dx_opcode[4] & ~dx_opcode[3] & dx_opcode[2] & dx_opcode[1] & ~dx_opcode[0]);
    assign alu_in_b = (dx_is_r_type_op || dx_is_branch_op) ? alu_b_mux_out : sx_imm;

    wire [4:0] alu_opcode, shamt;
    assign alu_opcode = dx_is_r_type_op ? dx_ir_out[6:2] : (dx_is_branch_op ? 5'b1 : 5'b0);
    assign shamt = dx_is_r_type_op ? dx_ir_out[11:7] : 5'b0;
    wire [31:0] alu_out, alu_out_ovf;
    wire is_not_equal, is_less_than, alu_overflow;
    alu alu_unit(alu_in_a, alu_in_b, alu_opcode, shamt, alu_out, is_not_equal, is_less_than, alu_overflow);

    // MultDiv
    wire ctrl_mult, ctrl_div;
    assign ctrl_mult = dx_is_r_type_op & ~alu_opcode[4] & ~alu_opcode[3] & alu_opcode[2] & alu_opcode[1] & ~alu_opcode[0];
    assign ctrl_div = dx_is_r_type_op & ~alu_opcode[4] & ~alu_opcode[3] & alu_opcode[2] & alu_opcode[1] & alu_opcode[0];

    wire [31:0] multdiv_in_a, multdiv_in_b, multdiv_ir, multdiv_result;
    wire multdiv_is_running, multdiv_exception, multdiv_result_ready;

    multdiv_input_latch multdiv_input_unit(clock, ctrl_mult | ctrl_div, multdiv_is_running, multdiv_result_ready, alu_in_a, alu_in_b, dx_ir_out, multdiv_in_a, multdiv_in_b, multdiv_ir);
    multdiv multdiv_unit(multdiv_in_a, multdiv_in_b, ctrl_mult, ctrl_div, clock, multdiv_result, multdiv_exception, multdiv_result_ready);

    // check for overflow, assign to rstatus
    wire overflow;
    assign overflow = alu_overflow | (multdiv_exception & multdiv_result_ready);

    wire [31:0] rstatus;
    overflow ovf_unit(multdiv_result_ready ? multdiv_ir[31:27] : dx_opcode, multdiv_result_ready ? multdiv_ir[6:2] : alu_opcode, rstatus);

    wire dx_is_jal_op, dx_is_setx_op;
    assign dx_is_jal_op = ~dx_opcode[4] & ~dx_opcode[3] & ~dx_opcode[2] & dx_opcode[1] & dx_opcode[0];
    assign dx_is_setx_op = dx_opcode[4] & ~dx_opcode[3] & dx_opcode[2] & ~dx_opcode[1] & dx_opcode[0];

    // tri buffers for assigning o input of xm latch
    wire [31:0] xm_o_in;
    tri_buffer tri_alu(alu_out, !overflow && !dx_is_jal_op && !dx_is_setx_op, xm_o_in);
    tri_buffer tri_ovf(rstatus, overflow && !dx_is_jal_op && !dx_is_setx_op, xm_o_in);
    tri_buffer tri_jal(dx_pc_out, !overflow && dx_is_jal_op && !dx_is_setx_op, xm_o_in);

    wire [31:0] t;
    assign t[31:27] = 5'b0;
    assign t[26:0] = dx_ir_out[26:0];
    tri_buffer tri_setx(t, !overflow && !dx_is_jal_op && dx_is_setx_op, xm_o_in);

    // XM latch
    wire [31:0] xm_b_out, xm_ir_out;
    wire xm_ovf_out;
    xm_latch xm(clock, xm_o_in, overflow, alu_b_mux_out, dx_ir_out, xm_o_out, xm_ovf_out, xm_b_out, xm_ir_out);
	
    // Data memory
    wire [4:0] xm_opcode;
    assign xm_opcode = xm_ir_out[31:27];
    wire xm_is_sw_op, xm_is_bex_op;
    assign xm_is_sw_op = ~xm_opcode[4] & ~xm_opcode[3] & xm_opcode[2] & xm_opcode[1] & xm_opcode[0];
    assign wren = xm_is_sw_op;

    assign address_dmem = xm_o_out;
    wire wm_bypass; // Early declaration needed for bypassing
    assign data = wm_bypass ? data_writeReg : xm_b_out;

    // MW latch
    wire [31:0] mw_o_out, mw_d_out, mw_ir_out;
    wire mw_ovf_out;
    mw_latch mw(clock, xm_o_out, xm_ovf_out, q_dmem, xm_ir_out, mw_o_out, mw_ovf_out, mw_d_out, mw_ir_out);

    // Writing back to Regfile
    wire [4:0] mw_opcode;
    assign mw_opcode = mw_ir_out[31:27];
    wire mw_is_r_type_op, mw_is_addi_op, mw_is_lw_op, mw_is_sw_op, mw_is_jal_op, mw_is_bex_op, mw_is_setx_op;
    assign mw_is_r_type_op = ~mw_opcode[4] & ~mw_opcode[3] & ~mw_opcode[2] & ~mw_opcode[1] & ~mw_opcode[0];
    assign mw_is_addi_op = ~mw_opcode[4] & ~mw_opcode[3] & mw_opcode[2] & ~mw_opcode[1] & mw_opcode[0];
    assign mw_is_lw_op = ~mw_opcode[4] & mw_opcode[3] & ~mw_opcode[2] & ~mw_opcode[1] & ~mw_opcode[0];
    assign mw_is_jal_op = ~mw_opcode[4] & ~mw_opcode[3] & ~mw_opcode[2] & mw_opcode[1] & mw_opcode[0];
    assign mw_is_setx_op = mw_opcode[4] & ~mw_opcode[3] & mw_opcode[2] & ~mw_opcode[1] & mw_opcode[0];

    // tri buffers for ctrl_writeReg
    tri_buffer_5 tri_normal_reg(mw_ir_out[26:22], !(mw_ovf_out || mw_is_setx_op) && !mw_is_jal_op && !(multdiv_result_ready && !multdiv_exception), ctrl_writeReg);
    tri_buffer_5 tri_status_reg(5'd30, (mw_ovf_out || mw_is_setx_op) && !mw_is_jal_op && !(multdiv_result_ready && !multdiv_exception), ctrl_writeReg);
    tri_buffer_5 tri_jal_reg(5'd31, !(mw_ovf_out || mw_is_setx_op) && mw_is_jal_op && !(multdiv_result_ready && !multdiv_exception), ctrl_writeReg);
    tri_buffer_5 tri_multdiv_reg(multdiv_ir[26:22], !(mw_ovf_out || mw_is_setx_op) && !mw_is_jal_op && (multdiv_result_ready && !multdiv_exception), ctrl_writeReg);

    assign data_writeReg = mw_is_lw_op ? mw_d_out : ((multdiv_result_ready && !multdiv_exception) ? multdiv_result : mw_o_out);
    assign ctrl_writeEnable = mw_is_r_type_op | mw_is_addi_op | mw_is_lw_op | mw_is_jal_op | mw_is_setx_op | (multdiv_result_ready && !multdiv_exception);

    // Bypass logic
    bypass bypass_unit(dx_ir_out, xm_ir_out, mw_ir_out, xm_ovf_out, mw_ovf_out, mux_a_select, mux_b_select, wm_bypass);

    // Stall logic
    stall stall_unit(fd_ir_out, dx_ir_out, xm_ir_out, multdiv_is_running, multdiv_result_ready, stall);

    // Control logic
    control control_unit(pc_next_def, dx_pc_out, sx_imm, alu_b_mux_out, dx_ir_out, is_not_equal, is_not_equal ? ~is_less_than : 1'b0, pc_next, branch_or_jump_taken);

endmodule
