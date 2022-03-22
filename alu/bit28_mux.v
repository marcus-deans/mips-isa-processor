module bit28_mux(out[27:0], select,in0[27:0],in1[27:0]);
  input select;
  input  [27:0]in0;
  input  [27:0]in1;
  output [27:0]out;
  assign out = select ? in1 : in0;
endmodule