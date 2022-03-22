module bit4_left_shifter(x, out);
    input [31:0] x;
    
    output [31:0] out;

    assign out[31:4] = x[27:0];
    assign out[3:0] = 4'b0;
endmodule