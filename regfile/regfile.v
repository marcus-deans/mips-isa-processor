module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;

	// decoder
	wire [31:0] writeEnable;
	decoder_32 decoder(ctrl_writeReg, ctrl_writeEnable, writeEnable);

	// create 32 registers, register 0 always has an output of 0 (disable writing)
	wire [31:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, 
		out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, 
		out23, out24, out25, out26, out27, out28, out29, out30, out31;
	
	register reg_0(data_writeReg, clock, 1'b0, 1'b1, ctrl_reset, out0);
	register reg_1(data_writeReg, clock, writeEnable[1], 1'b1, ctrl_reset, out1);
	register reg_2(data_writeReg, clock, writeEnable[2], 1'b1, ctrl_reset, out2);
	register reg_3(data_writeReg, clock, writeEnable[3], 1'b1, ctrl_reset, out3);
	register reg_4(data_writeReg, clock, writeEnable[4], 1'b1, ctrl_reset, out4);
	register reg_5(data_writeReg, clock, writeEnable[5], 1'b1, ctrl_reset, out5);
	register reg_6(data_writeReg, clock, writeEnable[6], 1'b1, ctrl_reset, out6);
	register reg_7(data_writeReg, clock, writeEnable[7], 1'b1, ctrl_reset, out7);
	register reg_8(data_writeReg, clock, writeEnable[8], 1'b1, ctrl_reset, out8);
	register reg_9(data_writeReg, clock, writeEnable[9], 1'b1, ctrl_reset, out9);
	register reg_10(data_writeReg, clock, writeEnable[10], 1'b1, ctrl_reset, out10);
	register reg_11(data_writeReg, clock, writeEnable[11], 1'b1, ctrl_reset, out11);
	register reg_12(data_writeReg, clock, writeEnable[12], 1'b1, ctrl_reset, out12);
	register reg_13(data_writeReg, clock, writeEnable[13], 1'b1, ctrl_reset, out13);
	register reg_14(data_writeReg, clock, writeEnable[14], 1'b1, ctrl_reset, out14);
	register reg_15(data_writeReg, clock, writeEnable[15], 1'b1, ctrl_reset, out15);
	register reg_16(data_writeReg, clock, writeEnable[16], 1'b1, ctrl_reset, out16);
	register reg_17(data_writeReg, clock, writeEnable[17], 1'b1, ctrl_reset, out17);
	register reg_18(data_writeReg, clock, writeEnable[18], 1'b1, ctrl_reset, out18);
	register reg_19(data_writeReg, clock, writeEnable[19], 1'b1, ctrl_reset, out19);
	register reg_20(data_writeReg, clock, writeEnable[20], 1'b1, ctrl_reset, out20);
	register reg_21(data_writeReg, clock, writeEnable[21], 1'b1, ctrl_reset, out21);
	register reg_22(data_writeReg, clock, writeEnable[22], 1'b1, ctrl_reset, out22);
	register reg_23(data_writeReg, clock, writeEnable[23], 1'b1, ctrl_reset, out23);
	register reg_24(data_writeReg, clock, writeEnable[24], 1'b1, ctrl_reset, out24);
	register reg_25(data_writeReg, clock, writeEnable[25], 1'b1, ctrl_reset, out25);
	register reg_26(data_writeReg, clock, writeEnable[26], 1'b1, ctrl_reset, out26);
	register reg_27(data_writeReg, clock, writeEnable[27], 1'b1, ctrl_reset, out27);
	register reg_28(data_writeReg, clock, writeEnable[28], 1'b1, ctrl_reset, out28);
	register reg_29(data_writeReg, clock, writeEnable[29], 1'b1, ctrl_reset, out29);
	register reg_30(data_writeReg, clock, writeEnable[30], 1'b1, ctrl_reset, out30);
	register reg_31(data_writeReg, clock, writeEnable[31], 1'b1, ctrl_reset, out31);

	// read values
	wire [31:0] readRegA, readRegB;
	decoder_32 decoderA(ctrl_readRegA, 1'b1, readRegA);
	decoder_32 decoderB(ctrl_readRegB, 1'b1, readRegB);

	tri_buffer tri_A_0(out0, readRegA[0], data_readRegA);
	tri_buffer tri_A_1(out1, readRegA[1], data_readRegA);
	tri_buffer tri_A_2(out2, readRegA[2], data_readRegA);
	tri_buffer tri_A_3(out3, readRegA[3], data_readRegA);
	tri_buffer tri_A_4(out4, readRegA[4], data_readRegA);
	tri_buffer tri_A_5(out5, readRegA[5], data_readRegA);
	tri_buffer tri_A_6(out6, readRegA[6], data_readRegA);
	tri_buffer tri_A_7(out7, readRegA[7], data_readRegA);
	tri_buffer tri_A_8(out8, readRegA[8], data_readRegA);
	tri_buffer tri_A_9(out9, readRegA[9], data_readRegA);
	tri_buffer tri_A_10(out10, readRegA[10], data_readRegA);
	tri_buffer tri_A_11(out11, readRegA[11], data_readRegA);
	tri_buffer tri_A_12(out12, readRegA[12], data_readRegA);
	tri_buffer tri_A_13(out13, readRegA[13], data_readRegA);
	tri_buffer tri_A_14(out14, readRegA[14], data_readRegA);
	tri_buffer tri_A_15(out15, readRegA[15], data_readRegA);
	tri_buffer tri_A_16(out16, readRegA[16], data_readRegA);
	tri_buffer tri_A_17(out17, readRegA[17], data_readRegA);
	tri_buffer tri_A_18(out18, readRegA[18], data_readRegA);
	tri_buffer tri_A_19(out19, readRegA[19], data_readRegA);
	tri_buffer tri_A_20(out20, readRegA[20], data_readRegA);
	tri_buffer tri_A_21(out21, readRegA[21], data_readRegA);
	tri_buffer tri_A_22(out22, readRegA[22], data_readRegA);
	tri_buffer tri_A_23(out23, readRegA[23], data_readRegA);
	tri_buffer tri_A_24(out24, readRegA[24], data_readRegA);
	tri_buffer tri_A_25(out25, readRegA[25], data_readRegA);
	tri_buffer tri_A_26(out26, readRegA[26], data_readRegA);
	tri_buffer tri_A_27(out27, readRegA[27], data_readRegA);
	tri_buffer tri_A_28(out28, readRegA[28], data_readRegA);
	tri_buffer tri_A_29(out29, readRegA[29], data_readRegA);
	tri_buffer tri_A_30(out30, readRegA[30], data_readRegA);
	tri_buffer tri_A_31(out31, readRegA[31], data_readRegA);

	tri_buffer tri_B_0(out0, readRegB[0], data_readRegB);
	tri_buffer tri_B_1(out1, readRegB[1], data_readRegB);
	tri_buffer tri_B_2(out2, readRegB[2], data_readRegB);
	tri_buffer tri_B_3(out3, readRegB[3], data_readRegB);
	tri_buffer tri_B_4(out4, readRegB[4], data_readRegB);
	tri_buffer tri_B_5(out5, readRegB[5], data_readRegB);
	tri_buffer tri_B_6(out6, readRegB[6], data_readRegB);
	tri_buffer tri_B_7(out7, readRegB[7], data_readRegB);
	tri_buffer tri_B_8(out8, readRegB[8], data_readRegB);
	tri_buffer tri_B_9(out9, readRegB[9], data_readRegB);
	tri_buffer tri_B_10(out10, readRegB[10], data_readRegB);
	tri_buffer tri_B_11(out11, readRegB[11], data_readRegB);
	tri_buffer tri_B_12(out12, readRegB[12], data_readRegB);
	tri_buffer tri_B_13(out13, readRegB[13], data_readRegB);
	tri_buffer tri_B_14(out14, readRegB[14], data_readRegB);
	tri_buffer tri_B_15(out15, readRegB[15], data_readRegB);
	tri_buffer tri_B_16(out16, readRegB[16], data_readRegB);
	tri_buffer tri_B_17(out17, readRegB[17], data_readRegB);
	tri_buffer tri_B_18(out18, readRegB[18], data_readRegB);
	tri_buffer tri_B_19(out19, readRegB[19], data_readRegB);
	tri_buffer tri_B_20(out20, readRegB[20], data_readRegB);
	tri_buffer tri_B_21(out21, readRegB[21], data_readRegB);
	tri_buffer tri_B_22(out22, readRegB[22], data_readRegB);
	tri_buffer tri_B_23(out23, readRegB[23], data_readRegB);
	tri_buffer tri_B_24(out24, readRegB[24], data_readRegB);
	tri_buffer tri_B_25(out25, readRegB[25], data_readRegB);
	tri_buffer tri_B_26(out26, readRegB[26], data_readRegB);
	tri_buffer tri_B_27(out27, readRegB[27], data_readRegB);
	tri_buffer tri_B_28(out28, readRegB[28], data_readRegB);
	tri_buffer tri_B_29(out29, readRegB[29], data_readRegB);
	tri_buffer tri_B_30(out30, readRegB[30], data_readRegB);
	tri_buffer tri_B_31(out31, readRegB[31], data_readRegB);

endmodule