// module bit2_mux(out, select, in0, in1);
//     input select;
//     input [31:0] in0, in1;
//     output [31:0] out;
//     assign out = select ? in1 : in0;
// endmodule

module bit2_mux(out, select,in0,in1);
  input select;
  input in0, in1;
  output out;
  wire w1,w2;
  assign out = select ? in1 : in0;
endmodule
