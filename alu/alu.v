module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    // check for subtraction, reassign A and B
    wire is_sub;
    wire [2:0] check_sub;

    not bit2(check_sub[2], ctrl_ALUopcode[2]);
    not bit1(check_sub[1], ctrl_ALUopcode[1]);
    assign check_sub[0] = ctrl_ALUopcode[0];

    and and_check_sub(is_sub, check_sub[2], check_sub[1], check_sub[0]);
    
    wire [31:0] data_B, data_operandB_inverted;
    bitwise_not not_b(data_operandB, data_operandB_inverted);
    assign data_B = is_sub ? data_operandB_inverted : data_operandB;

    wire [31:0] data_A;
    assign data_A = data_operandA;

    // bitwise or (propagate), bitwise and (generate)
    wire [31:0] prop, gen;
    
    bitwise_or a_or_b(data_A, data_B, prop);
    bitwise_and a_and_b(data_A, data_B, gen);

    // add/sub
    wire [31:0] sum;
    cla_full_adder add(data_A, data_B, is_sub, prop, gen, sum);

    // left and right shift
    wire [31:0] left_shifted_val, right_shifted_val;
    left_barrel_shifter left_shift(data_A, ctrl_shiftamt, left_shifted_val);
    right_barrel_shifter right_shift(data_A, ctrl_shiftamt, right_shifted_val);

    // mux for ALU op code
    wire [31:0] op6, op7;
    wire [2:0] ALUopcode_short;

    assign ALUopcode_short = ctrl_ALUopcode[2:0];
    assign op6 = 32'b0;
    assign op7 = 32'b0;

    mux_8 alu_mux(data_result, ALUopcode_short, sum, sum, gen, prop, left_shifted_val, right_shifted_val, op6, op7);

    // is not equal
    or check_not_equal(isNotEqual, sum[0], sum[1], sum[2], sum[3], sum[4], sum[5], sum[6], sum[7], sum[8], sum[9], sum[10], 
        sum[11], sum[12], sum[13], sum[14], sum[15], sum[16], sum[17], sum[18], sum[19], sum[20], sum[21], sum[22], sum[23],
        sum[24], sum[25], sum[26], sum[27], sum[28], sum[29], sum[30], sum[31]);

    // overflow
    wire not_msb_A, not_msb_B, not_msb_sum, pos_overflow, neg_overflow;
    not invert_msb_A(not_msb_A, data_A[31]);
    not invert_msb_B(not_msb_B, data_B[31]);
    not invert_msb_sum(not_msb_sum, sum[31]);
    and check_pos_overfow(pos_overflow, not_msb_A, not_msb_B, sum[31]);
    and check_neg_overflow(neg_overflow, data_A[31], data_B[31], not_msb_sum);
    or check_overflow(overflow, pos_overflow, neg_overflow);

    // is less than
    // check if MSB of sum is a 1 (sum is negative) AND no pos overflow
    // or if MSB of sum is 0 (sum is positive) AND neg overflow occurred (special case)
    wire normal_check_less_than, special_check_less_than;
    and check_normal_less_than(normal_check_less_than, sum[31], pos_overflow ? 0 : 1);
    and check_special_less_than(special_check_less_than, sum[31] ? 0 : 1, neg_overflow);
    or check_less_than(isLessThan, normal_check_less_than, special_check_less_than);

endmodule