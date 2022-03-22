module bit32_mux_4shift(out[31:0], select,in0[31:0],in1[31:0],in2[31:0],in3[31:0]);
  input [1:0] select;
  input[31:0]  in0, in1,in2,in3;
  output[31:0] out;
  wire[31:0]  w1;
  wire[31:0] w2;

  bit32_mux first_top(w1,select[0],in0,in1);
  bit32_mux first_bottom(w2, select[0],in2,in3);
  bit32_mux second(out, select[1],w1,w2);
endmodule