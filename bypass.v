module bypass(dx_ir_out, xm_ir_out, mw_ir_out, xm_ovf_out, mw_ovf_out, select_a, select_b, select_wm);
    input [31:0] dx_ir_out, xm_ir_out, mw_ir_out;
    input xm_ovf_out, mw_ovf_out;
    output [1:0] select_a, select_b;
    output select_wm;

    wire [4:0] dx_opcode, xm_opcode, mw_opcode;
    assign dx_opcode = dx_ir_out[31:27];
    assign xm_opcode = xm_ir_out[31:27];
    assign mw_opcode = mw_ir_out[31:27];

    wire xm_is_sw_op, mw_is_sw_op, xm_is_branch_op, mw_is_branch_op, xm_is_setx_op, mw_is_setx_op;
    assign xm_is_sw_op = ~xm_opcode[4] & ~xm_opcode[3] & xm_opcode[2] & xm_opcode[1] & xm_opcode[0];
    assign mw_is_sw_op = ~mw_opcode[4] & ~mw_opcode[3] & mw_opcode[2] & mw_opcode[1] & mw_opcode[0];
    assign xm_is_branch_op = (~xm_opcode[4] & ~xm_opcode[3] & ~xm_opcode[2] & xm_opcode[1] & ~xm_opcode[0]) | 
        (~xm_opcode[4] & ~xm_opcode[3] & xm_opcode[2] & xm_opcode[1] & ~xm_opcode[0]);
    assign mw_is_branch_op = (~mw_opcode[4] & ~mw_opcode[3] & ~mw_opcode[2] & mw_opcode[1] & ~mw_opcode[0]) | 
        (~mw_opcode[4] & ~mw_opcode[3] & mw_opcode[2] & mw_opcode[1] & ~mw_opcode[0]);
    assign xm_is_setx_op = xm_opcode[4] & ~xm_opcode[3] & xm_opcode[2] & ~xm_opcode[1] & xm_opcode[0];
    assign mw_is_setx_op = mw_opcode[4] & ~mw_opcode[3] & mw_opcode[2] & ~mw_opcode[1] & mw_opcode[0];

    wire dx_is_r_type_op, dx_is_bex_op;
    assign dx_is_r_type_op = ~dx_opcode[4] & ~dx_opcode[3] & ~dx_opcode[2] & ~dx_opcode[1] & ~dx_opcode[0];
    assign dx_is_bex_op = dx_opcode[4] & ~dx_opcode[3] & dx_opcode[2] & dx_opcode[1] & ~dx_opcode[0];

    // ALUinA, ALUinB bypassing
    wire [4:0] dx_a, dx_b, xm_rd_def, mw_rd_def, xm_rd, mw_rd;
    assign dx_a = dx_ir_out[21:17]; 
    // dx_b is Rd if not R type op (such as sw), otherwise Rt; set dx_b to be 30 if bex op
    assign dx_b = dx_is_r_type_op ? dx_ir_out[16:12] : (dx_is_bex_op ? 5'd30 : dx_ir_out[26:22]);
    assign xm_rd_def = xm_ir_out[26:22];
    assign mw_rd_def = mw_ir_out[26:22];
    // set xm_rd and mw_rd to 30 if overflow condition or setx op
    assign xm_rd = (xm_ovf_out || xm_is_setx_op) ? 5'd30 : xm_rd_def;
    assign mw_rd = (mw_ovf_out || mw_is_setx_op) ? 5'd30 : mw_rd_def;

    wire xm_a_bypass, mw_a_bypass, xm_b_bypass, mw_b_bypass;
    // do not bypass if sw op or branch op (branch op output has no significance) or rd is 0 (should always be 0)
    assign xm_a_bypass = !xm_is_sw_op && !xm_is_branch_op && dx_a == xm_rd && xm_rd != 5'b0; // for register 0 bypassing
    assign mw_a_bypass = !mw_is_sw_op && !mw_is_branch_op && dx_a == mw_rd && mw_rd != 5'b0; 
    assign xm_b_bypass = !xm_is_sw_op && !xm_is_branch_op && dx_b == xm_rd && xm_rd != 5'b0; 
    assign mw_b_bypass = !mw_is_sw_op && !mw_is_branch_op && dx_b == mw_rd && mw_rd != 5'b0;

    // Select bit logic, can also use muxes here
    assign select_a[1] = !xm_a_bypass && !mw_a_bypass;
    assign select_a[0] = !xm_a_bypass && mw_a_bypass;
    assign select_b[1] = !xm_b_bypass && !mw_b_bypass;
    assign select_b[0] = !xm_b_bypass && mw_b_bypass;

    // WM bypassing
    assign select_wm = xm_is_sw_op && (xm_rd_def == mw_rd_def);

endmodule