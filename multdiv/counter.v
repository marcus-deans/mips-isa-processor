module counter(clock, in_enable, reset, out);
    input clock, in_enable, reset;
    output [31:0] out;

    wire [31:0] one, counter_input;
    assign one = 32'b1;

    counter_reg register(counter_input, clock, in_enable, 1'b1, reset, out);
    cla_full_adder incrementer(out, one, 1'b0, out | one, out & one, counter_input);

endmodule