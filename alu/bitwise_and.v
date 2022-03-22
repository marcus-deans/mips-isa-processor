module bitwise_and(x, y, out);
    input [31:0] x, y;
    output [31:0] out;

    and bit0(out[0], x[0], y[0]);
    and bit1(out[1], x[1], y[1]);
    and bit2(out[2], x[2], y[2]);
    and bit3(out[3], x[3], y[3]);
    and bit4(out[4], x[4], y[4]);
    and bit5(out[5], x[5], y[5]);
    and bit6(out[6], x[6], y[6]);
    and bit7(out[7], x[7], y[7]);
    and bit8(out[8], x[8], y[8]);
    and bit9(out[9], x[9], y[9]);
    and bit10(out[10], x[10], y[10]);
    and bit11(out[11], x[11], y[11]);
    and bit12(out[12], x[12], y[12]);
    and bit13(out[13], x[13], y[13]);
    and bit14(out[14], x[14], y[14]);
    and bit15(out[15], x[15], y[15]);
    and bit16(out[16], x[16], y[16]);
    and bit17(out[17], x[17], y[17]);
    and bit18(out[18], x[18], y[18]);
    and bit19(out[19], x[19], y[19]);
    and bit20(out[20], x[20], y[20]);
    and bit21(out[21], x[21], y[21]);
    and bit22(out[22], x[22], y[22]);
    and bit23(out[23], x[23], y[23]);
    and bit24(out[24], x[24], y[24]);
    and bit25(out[25], x[25], y[25]);
    and bit26(out[26], x[26], y[26]);
    and bit27(out[27], x[27], y[27]);
    and bit28(out[28], x[28], y[28]);
    and bit29(out[29], x[29], y[29]);
    and bit30(out[30], x[30], y[30]);
    and bit31(out[31], x[31], y[31]);

endmodule