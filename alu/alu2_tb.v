`timescale 1ns/100ps
module alu2_tb;
    reg[31:0] A, B;
    reg[4:0] Shamt, opcode;

    wire[31:0] Result;
    wire isNotEqual, isLessThan, overflow;

    alu ALUU(.data_operandA(A), .data_operandB(B), .ctrl_ALUopcode(opcode), .ctrl_shiftamt(Shamt), .data_result(Result), .isNotEqual(isNotEqual), .isLessThan(isLessThan), .overflow(overflow));

    
    initial begin
        A = 1431655765;
        B = 252645135;
        Shamt = 0;
        opcode = 1;
        #10;
        $finish;
    end

    initial begin
        $dumpfile("test_alu.vcd");
        $dumpvars(0, alu2_tb);
    end

endmodule