module dx_latch(clock, in_pc, in_a, in_b, in_ir, out_pc, out_a, out_b, out_ir);
    input clock;
    input [31:0] in_pc, in_a, in_b, in_ir;
    output [31:0] out_pc, out_a, out_b, out_ir;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop
            dffe_ref dffe_pc(out_pc[i], in_pc[i], clock, 1'b1, 1'b0);
            dffe_ref dffe_a(out_a[i], in_a[i], clock, 1'b1, 1'b0);
            dffe_ref dffe_b(out_b[i], in_b[i], clock, 1'b1, 1'b0);
            dffe_ref dffe_ir(out_ir[i], in_ir[i], clock, 1'b1, 1'b0);
        end
    endgenerate
    
endmodule