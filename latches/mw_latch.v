module mw_latch(clock, in_o, in_ovf, in_d, in_ir, out_o, out_ovf, out_d, out_ir);
    input clock, in_ovf;
    input [31:0] in_o, in_d, in_ir;
    output [31:0] out_o, out_d, out_ir;
    output out_ovf;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop
            dffe_ref dffe_o(out_o[i], in_o[i], clock, 1'b1, 1'b0);
            dffe_ref dffe_d(out_d[i], in_d[i], clock, 1'b1, 1'b0);
            dffe_ref dffe_ir(out_ir[i], in_ir[i], clock, 1'b1, 1'b0);
        end

        dffe_ref dffe_ovf(out_ovf, in_ovf, clock, 1'b1, 1'b0);
        
    endgenerate
    
endmodule