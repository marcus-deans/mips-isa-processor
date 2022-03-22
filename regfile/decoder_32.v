module decoder_32(write_reg, enable, out);
    input [4:0] write_reg;
    input enable;
    output [31:0] out;

    wire [31:0] shifter_in;
    assign shifter_in = enable ? 32'b1 : 32'b0;

    left_barrel_shifter decoder(shifter_in, write_reg, out);

endmodule