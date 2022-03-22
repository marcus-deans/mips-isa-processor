module bit1_right_shifter(x, out);
    input [31:0] x;
    
    output [31:0] out;

    assign out[30:0] = x[31:1];
    assign out[31] = 1'b0;
endmodule