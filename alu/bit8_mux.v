// module bit8_mux(out, select, in0, in1, in2, in3, in4, in5, in6, in7);
//     input [2:0] select;
//     input [31:0] in0, in1, in2, in3, in4, in5, in6, in7;
//     output [31:0] out;
//     wire [31:0] w1, w2;
//     bit4_mux first_top(w1, select[1:0], in0, in1, in2, in3);
//     bit4_mux first_bottom(w2, select[1:0], in4, in5, in6, in7);
//     bit2_mux second(out, select[2], w1, w2);
// endmodule

module bit8_mux(out[7:0], select,in0[7:0],in1[7:0]);
  input select;
  input  [7:0]in0;
  input  [7:0]in1;
  output [7:0]out;
  assign out = select ? in1 : in0;
endmodule