// module bit4_mux(out, select, in0, in1, in2, in3);
//     input [1:0] select;
//     input [31:0] in0, in1, in2, in3;
//     output [31:0] out;
//     wire [31:0] w1, w2;
//     bit2_mux first_top(w1, select[0], in0, in1);
//     bit2_mux first_bottom(w2, select[0], in2, in3);
//     bit2_mux second(out, select[1], w1, w2);
// endmodule

module bit4_mux(out[3:0], select,in0[3:0],in1[3:0]);
  input select;
  input  [3:0]in0;
  input  [3:0]in1;
  output [3:0]out;
  assign out = select ? in1 : in0;
endmodule