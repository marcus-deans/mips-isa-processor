module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	// input clock, ctrl_writeEnable, ctrl_reset;
	// input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	// input [31:0] data_writeReg;

	// output [31:0] data_readRegA, data_readRegB;

	// // add your code here
	
	// // use decoder to determine which register should be written to
	// wire [31:0] decoded;
	// decoder32 decoder(ctrl_writeReg, ctrl_writeEnable, decoded);

	// // for writes, each output of the decoder must be checked to see whether writing is actually enabled
	// wire [31:0] writeEnable;
	// and writeEnable0_gate(writeEnable[0], decoded[0], ctrl_writeEnable);
	// and writeEnable1_gate(writeEnable[1], decoded[1], ctrl_writeEnable);
	// and writeEnable2_gate(writeEnable[2], decoded[2], ctrl_writeEnable);
	// and writeEnable3_gate(writeEnable[3], decoded[3], ctrl_writeEnable);
	// and writeEnable4_gate(writeEnable[4], decoded[4], ctrl_writeEnable);
	// and writeEnable5_gate(writeEnable[5], decoded[5], ctrl_writeEnable);
	// and writeEnable6_gate(writeEnable[6], decoded[6], ctrl_writeEnable);
	// and writeEnable7_gate(writeEnable[7], decoded[7], ctrl_writeEnable);
	// and writeEnable8_gate(writeEnable[8], decoded[8], ctrl_writeEnable);
	// and writeEnable9_gate(writeEnable[9], decoded[9], ctrl_writeEnable);
	// and writeEnable10_gate(writeEnable[10], decoded[10], ctrl_writeEnable);
	// and writeEnable11_gate(writeEnable[11], decoded[11], ctrl_writeEnable);
	// and writeEnable12_gate(writeEnable[12], decoded[12], ctrl_writeEnable);
	// and writeEnable13_gate(writeEnable[13], decoded[13], ctrl_writeEnable);
	// and writeEnable14_gate(writeEnable[14], decoded[14], ctrl_writeEnable);
	// and writeEnable15_gate(writeEnable[15], decoded[15], ctrl_writeEnable);
	// and writeEnable16_gate(writeEnable[16], decoded[16], ctrl_writeEnable);
	// and writeEnable17_gate(writeEnable[17], decoded[17], ctrl_writeEnable);
	// and writeEnable18_gate(writeEnable[18], decoded[18], ctrl_writeEnable);
	// and writeEnable19_gate(writeEnable[19], decoded[19], ctrl_writeEnable);
	// and writeEnable20_gate(writeEnable[20], decoded[20], ctrl_writeEnable);
	// and writeEnable21_gate(writeEnable[21], decoded[21], ctrl_writeEnable);
	// and writeEnable22_gate(writeEnable[22], decoded[22], ctrl_writeEnable);
	// and writeEnable23_gate(writeEnable[23], decoded[23], ctrl_writeEnable);
	// and writeEnable24_gate(writeEnable[24], decoded[24], ctrl_writeEnable);
	// and writeEnable25_gate(writeEnable[25], decoded[25], ctrl_writeEnable);
	// and writeEnable26_gate(writeEnable[26], decoded[26], ctrl_writeEnable);
	// and writeEnable27_gate(writeEnable[27], decoded[27], ctrl_writeEnable);
	// and writeEnable28_gate(writeEnable[28], decoded[28], ctrl_writeEnable);
	// and writeEnable29_gate(writeEnable[29], decoded[29], ctrl_writeEnable);
	// and writeEnable30_gate(writeEnable[30], decoded[30], ctrl_writeEnable);
	// and writeEnable31_gate(writeEnable[31], decoded[31], ctrl_writeEnable);

	// // create linking wires for the 32 registers
	// wire [31:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, 
	// 			out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, 
	// 			out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31;

	
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


	// create register 0 -> always has output of 0, irrespective of write
	reg32 reg0(data_writeReg, clock, 1'b0, 1'b1, ctrl_reset, out0); 
	// create the other 31 registers which can be written to
	reg32 reg1(data_writeReg, clock, writeEnable[1], 1'b1, ctrl_reset, out1);
	reg32 reg2(data_writeReg, clock, writeEnable[2], 1'b1, ctrl_reset, out2);
	reg32 reg3(data_writeReg, clock, writeEnable[3], 1'b1, ctrl_reset, out3);
	reg32 reg4(data_writeReg, clock, writeEnable[4], 1'b1, ctrl_reset, out4);
	reg32 reg5(data_writeReg, clock, writeEnable[5], 1'b1, ctrl_reset, out5);
	reg32 reg6(data_writeReg, clock, writeEnable[6], 1'b1, ctrl_reset, out6);
	reg32 reg7(data_writeReg, clock, writeEnable[7], 1'b1, ctrl_reset, out7);
	reg32 reg8(data_writeReg, clock, writeEnable[8], 1'b1, ctrl_reset, out8);
	reg32 reg9(data_writeReg, clock, writeEnable[9], 1'b1, ctrl_reset, out9);
	reg32 reg10(data_writeReg, clock, writeEnable[10], 1'b1, ctrl_reset, out10);
	reg32 reg11(data_writeReg, clock, writeEnable[11], 1'b1, ctrl_reset, out11);
	reg32 reg12(data_writeReg, clock, writeEnable[12], 1'b1, ctrl_reset, out12);
	reg32 reg13(data_writeReg, clock, writeEnable[13], 1'b1, ctrl_reset, out13);
	reg32 reg14(data_writeReg, clock, writeEnable[14], 1'b1, ctrl_reset, out14);
	reg32 reg15(data_writeReg, clock, writeEnable[15], 1'b1, ctrl_reset, out15);
	reg32 reg16(data_writeReg, clock, writeEnable[16], 1'b1, ctrl_reset, out16);
	reg32 reg17(data_writeReg, clock, writeEnable[17], 1'b1, ctrl_reset, out17);
	reg32 reg18(data_writeReg, clock, writeEnable[18], 1'b1, ctrl_reset, out18);
	reg32 reg19(data_writeReg, clock, writeEnable[19], 1'b1, ctrl_reset, out19);
	reg32 reg20(data_writeReg, clock, writeEnable[20], 1'b1, ctrl_reset, out20);
	reg32 reg21(data_writeReg, clock, writeEnable[21], 1'b1, ctrl_reset, out21);
	reg32 reg22(data_writeReg, clock, writeEnable[22], 1'b1, ctrl_reset, out22);
	reg32 reg23(data_writeReg, clock, writeEnable[23], 1'b1, ctrl_reset, out23);
	reg32 reg24(data_writeReg, clock, writeEnable[24], 1'b1, ctrl_reset, out24);
	reg32 reg25(data_writeReg, clock, writeEnable[25], 1'b1, ctrl_reset, out25);
	reg32 reg26(data_writeReg, clock, writeEnable[26], 1'b1, ctrl_reset, out26);
	reg32 reg27(data_writeReg, clock, writeEnable[27], 1'b1, ctrl_reset, out27);
	reg32 reg28(data_writeReg, clock, writeEnable[28], 1'b1, ctrl_reset, out28);
	reg32 reg29(data_writeReg, clock, writeEnable[29], 1'b1, ctrl_reset, out29);
	reg32 reg30(data_writeReg, clock, writeEnable[30], 1'b1, ctrl_reset, out30);
	reg32 reg31(data_writeReg, clock, writeEnable[31], 1'b1, ctrl_reset, out31);

	// read the values from the registers
	wire [31:0] readRegA, readRegB;
	decoder32 decoderA(ctrl_readRegA, 1'b1, readRegA);
	decoder32 decoderB(ctrl_readRegB, 1'b1, readRegB);

	tri_buffer tri_A0(out0, readRegA[0], data_readRegA);
	tri_buffer tri_A1(out1, readRegA[1], data_readRegA);
	tri_buffer tri_A2(out2, readRegA[2], data_readRegA);
	tri_buffer tri_A3(out3, readRegA[3], data_readRegA);
	tri_buffer tri_A4(out4, readRegA[4], data_readRegA);
	tri_buffer tri_A5(out5, readRegA[5], data_readRegA);
	tri_buffer tri_A6(out6, readRegA[6], data_readRegA);
	tri_buffer tri_A7(out7, readRegA[7], data_readRegA);
	tri_buffer tri_A8(out8, readRegA[8], data_readRegA);
	tri_buffer tri_A9(out9, readRegA[9], data_readRegA);
	tri_buffer tri_A10(out10, readRegA[10], data_readRegA);
	tri_buffer tri_A11(out11, readRegA[11], data_readRegA);
	tri_buffer tri_A12(out12, readRegA[12], data_readRegA);
	tri_buffer tri_A13(out13, readRegA[13], data_readRegA);
	tri_buffer tri_A14(out14, readRegA[14], data_readRegA);
	tri_buffer tri_A15(out15, readRegA[15], data_readRegA);
	tri_buffer tri_A16(out16, readRegA[16], data_readRegA);
	tri_buffer tri_A17(out17, readRegA[17], data_readRegA);
	tri_buffer tri_A18(out18, readRegA[18], data_readRegA);
	tri_buffer tri_A19(out19, readRegA[19], data_readRegA);
	tri_buffer tri_A20(out20, readRegA[20], data_readRegA);
	tri_buffer tri_A21(out21, readRegA[21], data_readRegA);
	tri_buffer tri_A22(out22, readRegA[22], data_readRegA);
	tri_buffer tri_A23(out23, readRegA[23], data_readRegA);
	tri_buffer tri_A24(out24, readRegA[24], data_readRegA);
	tri_buffer tri_A25(out25, readRegA[25], data_readRegA);
	tri_buffer tri_A26(out26, readRegA[26], data_readRegA);
	tri_buffer tri_A27(out27, readRegA[27], data_readRegA);
	tri_buffer tri_A28(out28, readRegA[28], data_readRegA);
	tri_buffer tri_A29(out29, readRegA[29], data_readRegA);
	tri_buffer tri_A30(out30, readRegA[30], data_readRegA);
	tri_buffer tri_A31(out31, readRegA[31], data_readRegA);

	tri_buffer tri_B0(out0, readRegB[0], data_readRegB);
	tri_buffer tri_B1(out1, readRegB[1], data_readRegB);
	tri_buffer tri_B2(out2, readRegB[2], data_readRegB);
	tri_buffer tri_B3(out3, readRegB[3], data_readRegB);
	tri_buffer tri_B4(out4, readRegB[4], data_readRegB);
	tri_buffer tri_B5(out5, readRegB[5], data_readRegB);
	tri_buffer tri_B6(out6, readRegB[6], data_readRegB);
	tri_buffer tri_B7(out7, readRegB[7], data_readRegB);
	tri_buffer tri_B8(out8, readRegB[8], data_readRegB);
	tri_buffer tri_B9(out9, readRegB[9], data_readRegB);
	tri_buffer tri_B10(out10, readRegB[10], data_readRegB);
	tri_buffer tri_B11(out11, readRegB[11], data_readRegB);
	tri_buffer tri_B12(out12, readRegB[12], data_readRegB);
	tri_buffer tri_B13(out13, readRegB[13], data_readRegB);
	tri_buffer tri_B14(out14, readRegB[14], data_readRegB);
	tri_buffer tri_B15(out15, readRegB[15], data_readRegB);
	tri_buffer tri_B16(out16, readRegB[16], data_readRegB);
	tri_buffer tri_B17(out17, readRegB[17], data_readRegB);
	tri_buffer tri_B18(out18, readRegB[18], data_readRegB);
	tri_buffer tri_B19(out19, readRegB[19], data_readRegB);
	tri_buffer tri_B20(out20, readRegB[20], data_readRegB);
	tri_buffer tri_B21(out21, readRegB[21], data_readRegB);
	tri_buffer tri_B22(out22, readRegB[22], data_readRegB);
	tri_buffer tri_B23(out23, readRegB[23], data_readRegB);
	tri_buffer tri_B24(out24, readRegB[24], data_readRegB);
	tri_buffer tri_B25(out25, readRegB[25], data_readRegB);
	tri_buffer tri_B26(out26, readRegB[26], data_readRegB);
	tri_buffer tri_B27(out27, readRegB[27], data_readRegB);
	tri_buffer tri_B28(out28, readRegB[28], data_readRegB);
	tri_buffer tri_B29(out29, readRegB[29], data_readRegB);
	tri_buffer tri_B30(out30, readRegB[30], data_readRegB);
	tri_buffer tri_B31(out31, readRegB[31], data_readRegB);
endmodule
