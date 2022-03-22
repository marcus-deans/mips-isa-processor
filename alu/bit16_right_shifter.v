module bit16_right_shifter(x, out);
    input [31:0] x;
    
    output [31:0] out;

    assign out[15:0] = x[31:16];
    assign out[30:16] = x[31] ? 15'b111111111111111: 15'b0;
    assign out[31] = x[31];
endmodule