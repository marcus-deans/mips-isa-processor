module overflow(op, alu_op, rstatus);
    input [4:0] op, alu_op;
    output [31:0] rstatus;

    wire is_r_type_op;
    assign is_r_type_op = ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];

    wire is_add, is_addi, is_sub, is_mul, is_div;
    assign is_add = is_r_type_op & ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & ~alu_op[1] & ~alu_op[0];
    assign is_addi = ~op[4] & ~op[3] & op[2] & ~op[1] & op[0];
    assign is_sub = is_r_type_op & ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & ~alu_op[1] & alu_op[0];
    assign is_mul = is_r_type_op & ~alu_op[4] & ~alu_op[3] & alu_op[2] & alu_op[1] & ~alu_op[0];
    assign is_div = is_r_type_op & ~alu_op[4] & ~alu_op[3] & alu_op[2] & alu_op[1] & alu_op[0];

    // assigning rstatus based on alu_op
    tri_state_buffer tri_add(32'd1, is_add, rstatus);
    tri_state_buffer tri_addi(32'd2, is_addi, rstatus);
    tri_state_buffer tri_sub(32'd3, is_sub, rstatus);
    tri_state_buffer tri_mul(32'd4, is_mul, rstatus);
    tri_state_buffer tri_div(32'd5, is_div, rstatus);

endmodule