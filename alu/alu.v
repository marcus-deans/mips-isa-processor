// module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
//     input [31:0] data_operandA, data_operandB;
//     input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

//     output [31:0] data_result;
//     output isNotEqual, isLessThan, overflow;

//     // add your code here:
//     // Wire to check for subtraction
//     wire [2:0] compute_sub;
//     wire check_sub;
    
//     // Extract and save the relevant fields from the Opcode to determine action
//     assign compute_sub[0] = ctrl_ALUopcode[0];
//     not bit_1(compute_sub[1], ctrl_ALUopcode[1]);
//     not bit_2(compute_sub[2], ctrl_ALUopcode[2]);

//     // Compute whether the operation is in fact subtraction by ANDing the relevant parts of the opcode
//     and and_compute_sub(check_sub, compute_sub[0], compute_sub[1], compute_sub[2]);

//     // Setup data fires
//     wire[31:0] data_A;
//     wire [31:0] data_B;
//     wire [31:0] data_operandB_inverted;

//     // Assign data appropriately. Check if subtraction in which case use the inverted version of B's operand
//     assign data_A = data_operandA;
//     bit_not not_b(data_operandB, data_operandB_inverted);
//     assign data_B = check_sub ? data_operandB_inverted : data_operandB;

//     // Propagate and generate
//     wire [31:0] propagate, gen;

//     // Addition/Subtraction: output and wire and adder setup
//     wire [31:0] sum;
//     cla_adder add(data_A, data_B, check_sub, propagate, gen, sum);

//     // Left and Right Shift
//     wire [31:0] right_shifted_value, left_shifted_value;
//     barrel_right_shifter right_shifter(data_A, ctrl_shiftamt, right_shifted_value);
//     barrel_left_shifter left_shifter(data_A, ctrl_shiftamt, left_shifted_value);

//     // Generate comes from bitwise and, propagate comes from bitwsie or
//     bit_and a_and_b(data_A, data_B, gen);
//     bit_or a_or_b(data_A, data_B, propagate);

//     //  Determine ALU upcode for equal operations
//     wire[31:0] op6, op7;
//     wire[2:0] ALUopcode_short;
//     // wire[2:0] abbreviated_ALUopcode;

//     assign op6 = 32'b0;
//     assign op7 = 32'b0;
//     // assign abbreviated_ALUopcode = ctrl_ALUopcode[2:0];

//     // Feed the inputs into the appropriate operation using the ALU
//     bit8_mux alu_mux(data_result, ctrl_ALUopcode[2:0], sum, sum, gen, propagate, left_shifted_value, right_shifted_value, op6, op7);

//     // Compute complements
//     wire not_msb_A, not_msb_B, not_msb_sum;
//     not complement_msb_A(not_msb_A, data_A[31]);
//     not complement_msb_B(not_msb_B, data_B[31]);
//     not complement_msb_sum(not_msb_sum, sum[31]);

//     // Check for Overflow
//     wire overflow_pos, overflow_neg;
//     and check_overflow_neg(overflow_neg, data_A[31], data_B[31], not_msb_sum);
//     and check_pos_overfow(overflow_pos, not_msb_A, not_msb_B, sum[31]);
//     or check_overflow(overflow, overflow_pos, overflow_neg);

//     // Determine whether less than: either MSB of sum = 1 (positive) and negative overflow, or MSB of sum = 1 (negative) and no positive overflow
//     wire check_less_than_standard, check_less_than_special;
//     and check_special_less_than(check_less_than_special, sum[31] ? 0 : 1, overflow_neg);
//     and check_normal_less_than(check_less_than_standard, sum[31], overflow_pos ? 0 : 1);
//     or check_less_than(isLessThan, check_less_than_standard, check_less_than_special);


//     // Check that values are not equal
//     or check_not_equal(isNotEqual, sum[0], sum[1], sum[2], sum[3], sum[4], sum[5], sum[6], sum[7], sum[8], sum[9], sum[10], 
//         sum[11], sum[12], sum[13], sum[14], sum[15], sum[16], sum[17], sum[18], sum[19], sum[20], sum[21], sum[22], sum[23],
//         sum[24], sum[25], sum[26], sum[27], sum[28], sum[29], sum[30], sum[31]);
// endmodule

module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    // Store results of standard operations
    wire [0:31]addedtogether, subtracted, notA, notB, andEd, orEd;

    // Overflow
    wire overflowAdd, overflowSub;
    wire addOverflow, subtractOverflow;

    // Calculate standard basic operations
    bit32_cla tb1(addedtogether,data_operandA,data_operandB,addOverflow,1'b0);
    bit32_not n1(notB,data_operandB);
    bit32_not n2(notA,data_operandA);
    bit32_cla tb2(subtracted,data_operandA,notB,subtractOverflow,1'b1);

    wire w1,w2,w3,w4,notAT,subTwoValue, notS,w5,w6,w7,w8,w9,w10,w11,w12,subtractOutputValue;



    // Shifts
    wire [0:31] left_shift, right_shift;
    wire [0:31]ls0, ls1, ls2, ls3, ls4, rs0, rs1, rs2, rs3, rs4, temp, temp1;

    // Compute combinations of the standard operations
    and combo_and1(w1,notA[0],notB[0],addedtogether[0]);
    and combo_and2(w2,notA[0],notB[0],subtracted[0]);
    and combo_and3(w6,notA[0],data_operandB[31]);
    and combo_and4(w7,data_operandA[31],notB[0]);
    or combo_or1(w8,w6,w7);
    and combo_and5(w9,data_operandB[31],data_result[31],w8);
    not combo_or2(w11,data_result[31]);
    and combo_and6(w10,notB[0],w11,w8);
    or combo_or3(subtractOutputValue,w10,w9);
    not combo_not1(notAT,addedtogether[0]);
    not combo_not2(notS,subtracted[0]);
    and combo_and7(w3,data_operandA[31],data_operandB[31],notAT);
    and combo_and8(w4,data_operandA[31],data_operandB[31],notS);
    or combo_or4(overflowAdd,w1,w3);
    or combo_or5(overflowSub,w2,w4);

    // Determine whether the values are equal by comparing whether any of the values are different (i.e. a 1)
    or o1(isNotEqual,subtracted[0],subtracted[1],subtracted[2],subtracted[3],
      subtracted[4],subtracted[5],subtracted[6],subtracted[7],subtracted[8],
      subtracted[9],subtracted[10],subtracted[11],subtracted[12],subtracted[13],subtracted[14],
      subtracted[15],subtracted[16],subtracted[17],subtracted[18],subtracted[19],subtracted[20],
      subtracted[21],subtracted[22],subtracted[23],subtracted[24],subtracted[25],subtracted[26],
      subtracted[27],subtracted[28],subtracted[29],subtracted[30],subtracted[31]);
    or combo_or6(w12, subtracted[0],1'b0);
    not combo_not3(w5,subtracted[0]);
    bit2_mux lessthanmux(isLessThan,subtractOutputValue,w12,w5);
    bit32_and andEdmux(andEd,data_operandA,data_operandB);
    bit32_or orEdmux(orEd,data_operandA,data_operandB);


    bit32_or o999(ls0,data_operandA,0);

    //shift 16
    bit16_mux m1(ls1[0:15],ctrl_shiftamt[4], ls0[0:15], ls0[16:31]);
    bit16_mux m2(ls1[16:31],ctrl_shiftamt[4], ls0[16:31], 16'b0);
    //shift 8
    bit24_mux m3(ls2[0:23],ctrl_shiftamt[3], ls1[0:23], ls1[8:31]);
    bit8_mux m4(ls2[24:31],ctrl_shiftamt[3], ls1[24:31], 8'b0);
    //shift 4
    bit28_mux m5(ls3[0:27],ctrl_shiftamt[2], ls2[0:27], ls2[4:31]);
    bit4_mux m6(ls3[28:31],ctrl_shiftamt[2], ls2[28:31], 4'b0);
    //shift 2
    bit30_mux m7(ls4[0:29],ctrl_shiftamt[1], ls3[0:29], ls3[2:31]);
    bit2_double_mux m8(ls4[30:31],ctrl_shiftamt[1], ls3[30:31], 2'b0);
    //shift 1
    bit31_mux m9(left_shift[0:30],ctrl_shiftamt[0], ls4[0:30], ls4[1:31]);
    bit2_mux m10(left_shift[31],ctrl_shiftamt[0], ls4[31], 1'b0);

    //right
    bit32_and a97(temp1,32'b0,32'b0);

    bit32_or o234(rs0,data_operandA,32'b0);
    or comb_or1(temp[0],rs0[0],temp1[0]);
    or comb_or2(temp[1],rs0[0],temp1[0]);
    or comb_or3(temp[2],rs0[0],temp1[0]);
    or comb_or4(temp[3],rs0[0],temp1[0]);
    or comb_or5(temp[4],rs0[0],temp1[0]);
    or comb_or6(temp[5],rs0[0],temp1[0]);
    or comb_or7(temp[6],rs0[0],temp1[0]);
    or comb_or8(temp[7],rs0[0],temp1[0]);
    or comb_or9(temp[8],rs0[0],temp1[0]);
    or comb_or10(temp[9],rs0[0],temp1[0]);
    or comb_or11(temp[10],rs0[0],temp1[0]);
    or comb_or12(temp[11],rs0[0],temp1[0]);
    or comb_or13(temp[12],rs0[0],temp1[0]);
    or comb_or14(temp[13],rs0[0],temp1[0]);
    or comb_or15(temp[14],rs0[0],temp1[0]);
    or comb_or16(temp[15],rs0[0],temp1[0]);

    //shift 16
    bit16_mux m11(rs1[16:31],ctrl_shiftamt[4], rs0[16:31], rs0[0:15]);
    bit16_mux m12(rs1[0:15],ctrl_shiftamt[4], rs0[0:15], temp[0:15]);
    //shift 8
    bit24_mux m13(rs2[8:31],ctrl_shiftamt[3], rs1[8:31], rs1[0:23]);
    bit8_mux m14(rs2[0:7],ctrl_shiftamt[3], rs1[0:7], temp[0:7]);
    //shift 4
    bit28_mux m15(rs3[4:31],ctrl_shiftamt[2], rs2[4:31], rs2[0:27]);
    bit4_mux m16(rs3[0:3],ctrl_shiftamt[2], rs2[0:3],temp[0:3]);
    //shift 2
    bit30_mux m17(rs4[2:31],ctrl_shiftamt[1], rs3[2:31], rs3[0:29]);
    bit2_double_mux m18(rs4[0:1],ctrl_shiftamt[1], rs3[0:1], temp[0:1]);
    //shift 1
    bit31_mux m19(right_shift[1:31],ctrl_shiftamt[0], rs4[1:31], rs4[0:30]);
    bit2_mux m20(right_shift[0],ctrl_shiftamt[0], rs4[0], temp[0]);

    bit32_mux_8shift m21(data_result,ctrl_ALUopcode[2:0],addedtogether,subtracted,andEd,orEd,left_shift,right_shift,32'b0,32'b0);
    //assign overflow = ctrl_ALUopcode[0]? overflowSub:overflowAdd;
    bit2_mux m22224(overflow,ctrl_ALUopcode[0],overflowAdd,subtractOutputValue);

endmodule