module bit16_mux(out[15:0], select,in0[15:0],in1[15:0]);
  input select;
  input  [15:0]in0;
  input  [15:0]in1;
  output [15:0]out;
  assign out = select ? in1 : in0;
endmodule