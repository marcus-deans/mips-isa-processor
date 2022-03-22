module one_bit_add(a, b, c_in, s);
    input a, b, c_in;
    output s;
    
    xor sum(s, a, b, c_in);
endmodule