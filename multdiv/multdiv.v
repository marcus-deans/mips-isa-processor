module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    // check if current operation is mult/div
    wire is_mult, is_div;
    // ctrl_latch latch(ctrl_MULT, ctrl_DIV, is_mult); // this no longer works b/c it assigns is_mult x for s = r = 0, causing data_resultRDY to be x for non-multdiv ops
    ctrl_reg check_mult(clock, ctrl_MULT, ctrl_MULT | ctrl_DIV, is_mult); // new register approach
    ctrl_reg check_div(clock, ctrl_DIV, ctrl_MULT | ctrl_DIV, is_div);

    // counters for mult/div
    wire [31:0] count, mult_count, div_count;
    counter mult_counter(clock, is_mult, ctrl_MULT, mult_count);
    counter div_counter(clock, is_div, ctrl_DIV, div_count);

    // instantiate mult/div
    wire [31:0] mult_result, div_result, div_remainder;
    wire mult_exception, div_exception;
    mult multiplier(data_operandA, data_operandB, clock, mult_count, mult_result, mult_exception);
    div divider(data_operandA, data_operandB, clock, div_count, div_result, div_remainder, div_exception);

    // assign outputs
    assign data_result = is_mult ? mult_result : (is_div ? div_result : 32'b0);
    assign data_exception = is_mult ? mult_exception : (is_div ? div_exception : 1'b0);
    assign data_resultRDY = is_mult ? (mult_count[4] & ~mult_count[3] & ~mult_count[2] & ~mult_count[1] & mult_count[0]) : 
        (is_div ? (div_count[5] & ~div_count[4] & ~div_count[3] & ~div_count[2] & ~div_count[1] & div_count[0]) : 1'b0);

endmodule