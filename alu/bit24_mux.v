module bit24_mux(out[23:0], select,in0[23:0],in1[23:0]);
  input select;
  input  [23:0]in0;
  input  [23:0]in1;
  output [23:0]out;
  assign out = select ? in1 : in0;
endmodule