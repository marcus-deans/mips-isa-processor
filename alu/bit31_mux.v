module bit31_mux(out[30:0], select,in0[30:0],in1[30:0]);
  input select;
  input  [30:0]in0;
  input  [30:0]in1;
  output [30:0]out;
  assign out = select ? in1 : in0;
endmodule