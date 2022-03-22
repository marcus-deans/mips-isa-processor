module barrel_right_shifter(x, amount, out);
    // inputs, value and amount
    input [31:0] x;
    input [4:0] amount;

    // output that has been shifted
    output [31:0] out;

    // Setup wire to carry the information between the constitutent shifters
    wire [31:0] w1, w2, w3, w4, w5;
    wire [31:0] shift1, shift2, shift3, shift4;


    // Shift the bits accordingly as needed and propagating remaining shifts "down" the "waterfall"
    bit16_right_shifter s16(x, w1);
    assign shift1 = amount[4] ? w1 : x;

    bit8_right_shifter s8(shift1, w2);
    assign shift2 = amount[3] ? w2 : shift1;

    bit4_right_shifter s4(shift2, w3);
    assign shift3 = amount[2] ? w3 : shift2;

    bit2_right_shifter s2(shift3, w4);
    assign shift4 = amount[1] ? w4 : shift3;

    bit1_right_shifter s1(shift4, w5);
    assign out = amount[0] ? w5 : shift4;
endmodule
