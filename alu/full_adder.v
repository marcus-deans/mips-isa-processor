module full_adder(sum, c_out, a, b, c_in);
  input a, b, c_in;
  output sum, c_out;

  wire w1,w2,w3,w4,w5,w6,w7;

  nand n1(w1, a, b );  // 32U On
  nand n2(w2, a, w1);  // 28D On
  nand n3(w3, b, w1);  //29U On
  nand n4(w4, w3, w2); //19U Off
  nand n5(w5, w4, c_in); //23D On
  nand n6(w6, w4, w5); // 18D On
  nand n7(w7, c_in, w5); //13D  On
  nand n8(sum, w7, w6); // 9D
  nand n9(c_out, w5, w1); // 10U

endmodule
