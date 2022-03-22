module fd_latch(clock, in_enable, in_pc, in_ir, out_pc, out_ir);
    input clock, in_enable;
    input [31:0] in_pc, in_ir;
    output [31:0] out_pc, out_ir;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop
            dffe_ref dffe_pc(out_pc[i], in_pc[i], clock, in_enable, 1'b0);
            dffe_ref dffe_ir(out_ir[i], in_ir[i], clock, in_enable, 1'b0);
        end
    endgenerate
    
endmodule