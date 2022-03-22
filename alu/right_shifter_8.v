module right_shifter_8(x, out);
    input [31:0] x;
    output [31:0] out;

    assign out[23:0] = x[31:8];
    assign out[30:24] = x[31] ? 7'b1111111 : 7'b0;
    assign out[31] = x[31];
    
endmodule