module right_barrel_shifter(x, amt, out);
    input [31:0] x;
    input [4:0] amt;
    output [31:0] out;

    wire [31:0] w1, w2, w3, w4, w5;
    wire [31:0] shift1, shift2, shift3, shift4;

    right_shifter_16 s16(x, w1);
    assign shift1 = amt[4] ? w1 : x;

    right_shifter_8 s8(shift1, w2);
    assign shift2 = amt[3] ? w2 : shift1;

    right_shifter_4 s4(shift2, w3);
    assign shift3 = amt[2] ? w3 : shift2;

    right_shifter_2 s2(shift3, w4);
    assign shift4 = amt[1] ? w4 : shift3;

    right_shifter_1 s1(shift4, w5);
    assign out = amt[0] ? w5 : shift4;

endmodule