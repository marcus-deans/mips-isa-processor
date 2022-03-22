module bit2_left_shifter(x, out);
    input [31:0] x;
    
    output [31:0] out;

    assign out[31:2] = x[29:0];
    assign out[1:0] = 2'b0;
endmodule