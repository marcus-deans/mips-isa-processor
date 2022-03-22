module right_shifter_4(x, out);
    input [31:0] x;
    output [31:0] out;

    assign out[27:0] = x[31:4];
    assign out[30:28] = x[31] ? 3'b111 : 3'b0;
    assign out[31] = x[31];
    
endmodule