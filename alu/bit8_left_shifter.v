module bit8_left_shifter(x, out);
    input [31:0] x;
    
    output [31:0] out;

    assign out[31:8] = x[23:0];
    assign out[7:0] = 8'b0;
endmodule