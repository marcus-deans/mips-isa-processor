module bit32_mux_8shift(out[31:0], select[2:0],in0[31:0],in1[31:0],in2[31:0],in3[31:0],in4[31:0],in5[31:0],in6[31:0],in7[31:0]);
  input [2:0]select;
  input[31:0]  in0,in1,in2,in3,in4,in5,in6,in7;
  output[31:0]  out;
  wire[31:0]  w1, w2;
  bit32_mux_4shift first_top(w1[31:0],select[1:0],in0[31:0],in1[31:0],in2[31:0],in3[31:0]);
  bit32_mux_4shift first_bottom(w2[31:0],select[1:0],in4[31:0],in5[31:0],in6[31:0],in7[31:0]);
  bit32_mux second(out, select[2],w1,w2);
endmodule