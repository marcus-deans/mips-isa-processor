`timescale 1ns/100ps
module practice_test_tb;
  reg signed [31:0] data_operandA, data_operandB;
  reg[4:0] ctrl_ALUopcode, ctrl_shiftamt;
  wire signed [31:0] data_result;
  wire isNotEqual, isLessThan, overflow;
  wire S, Cout;
  alu alutester(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

  initial begin
    data_operandA=1;
    data_operandB=0;
    ctrl_ALUopcode=5'b00000;
    ctrl_shiftamt=0;


    #80;
    $finish;
  end
  always @(data_operandA, data_operandB,ctrl_ALUopcode, ctrl_shiftamt) begin
    #1;
    $display("A:%b, B:%b, data_result:%b, overflow:%b, lessthan:%b",data_operandA, data_operandB,data_result,overflow,isLessThan);
  end

  initial begin
    $dumpfile("practice_test_tb_Waveform.vcd");
    $dumpvars(0, practice_test_tb);
  end
endmodule
