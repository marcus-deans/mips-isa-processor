module overflow(op, alu_op, rstatus);
    input [4:0] op, alu_op;
    output [31:0] rstatus;

    // Identify whether operation is add immediate which is not type R
    wire is_addi;
    assign is_addi = ~op[4] & ~op[3] & op[2] & ~op[1] & op[0];

    // Identify whether operation is type R and store
    wire is_r_type_op;
    assign is_r_type_op = ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];

    // If operation is type R, then identify what fundamental operation it is (add, subtract, multiply, divide)
    wire is_add, is_sub, is_mult, is_div;
    assign is_add = is_r_type_op & ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & ~alu_op[1] & ~alu_op[0];
    assign is_sub = is_r_type_op & ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & ~alu_op[1] & alu_op[0];
    assign is_mult = is_r_type_op & ~alu_op[4] & ~alu_op[3] & alu_op[2] & alu_op[1] & ~alu_op[0];
    assign is_div = is_r_type_op & ~alu_op[4] & ~alu_op[3] & alu_op[2] & alu_op[1] & alu_op[0];

    // Store the identified rstatus based on the ALU operation in tri state buffers
    tri_buffer tri_add(32'd1, is_add, rstatus);
    tri_buffer tri_addi(32'd2, is_addi, rstatus);
    tri_buffer tri_sub(32'd3, is_sub, rstatus);
    tri_buffer tri_mult(32'd4, is_mult, rstatus);
    tri_buffer tri_div(32'd5, is_div, rstatus);
endmodule