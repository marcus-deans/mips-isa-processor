module bitwise_not(x, out);
    input [31:0] x;
    output [31:0] out;

    not bit0(out[0], x[0]);
    not bit1(out[1], x[1]);
    not bit2(out[2], x[2]);
    not bit3(out[3], x[3]);
    not bit4(out[4], x[4]);
    not bit5(out[5], x[5]);
    not bit6(out[6], x[6]);
    not bit7(out[7], x[7]);
    not bit8(out[8], x[8]);
    not bit9(out[9], x[9]);
    not bit10(out[10], x[10]);
    not bit11(out[11], x[11]);
    not bit12(out[12], x[12]);
    not bit13(out[13], x[13]);
    not bit14(out[14], x[14]);
    not bit15(out[15], x[15]);
    not bit16(out[16], x[16]);
    not bit17(out[17], x[17]);
    not bit18(out[18], x[18]);
    not bit19(out[19], x[19]);
    not bit20(out[20], x[20]);
    not bit21(out[21], x[21]);
    not bit22(out[22], x[22]);
    not bit23(out[23], x[23]);
    not bit24(out[24], x[24]);
    not bit25(out[25], x[25]);
    not bit26(out[26], x[26]);
    not bit27(out[27], x[27]);
    not bit28(out[28], x[28]);
    not bit29(out[29], x[29]);
    not bit30(out[30], x[30]);
    not bit31(out[31], x[31]);

endmodule