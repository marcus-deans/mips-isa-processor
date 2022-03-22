module bit30_mux(out[29:0], select,in0[29:0],in1[29:0]);
  input select;
  input  [29:0]in0;
  input  [29:0]in1;
  output [29:0]out;
  assign out = select ? in1 : in0;
endmodule