module bit32_mux(out[31:0], select,in0[31:0],in1[31:0]);
  input select;
  input  [31:0]in0;
  input  [31:0]in1;
  output [31:0]out;
  assign out = select ? in1 : in0;
endmodule