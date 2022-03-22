module left_shifter_16(x, out);
    input [31:0] x;
    output [31:0] out;

    assign out[31:16] = x[15:0];
    assign out[15:0] = 16'b0;

endmodule