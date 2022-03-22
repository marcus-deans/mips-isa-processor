module bit1_left_shifter(x, out);
    input [31:0] x;
    
    output [31:0] out;

    assign out[31:1] = x[30:0];
    assign out[0] = 1'b0;
endmodule