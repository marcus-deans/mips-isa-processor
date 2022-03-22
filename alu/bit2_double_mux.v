module bit2_double_mux(out[1:0], select, in0[1:0], in1[1:0]);
    input select;
    input [1:0] in0;
    input [1:0] in1;
    output [1:0] out;
    assign out = select ? in1 : in0;
endmodule