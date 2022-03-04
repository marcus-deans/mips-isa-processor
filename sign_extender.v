module sign_extender(B, A);
    input[16:0] A;
    output[31:0] B;

    assign B[16:0] = A[16:0];
    assign B[17] = A[16];
    assign B[18] = A[16];
    assign B[19] = A[16];
    assign B[20] = A[16];
    assign B[21] = A[16];
    assign B[22] = A[16];
    assign B[23] = A[16];
    assign B[24] = A[16];
    assign B[25] = A[16];
    assign B[26] = A[16];
    assign B[27] = A[16];
    assign B[28] = A[16];
    assign B[29] = A[16];
    assign B[30] = A[16];
    assign B[31] = A[16];

endmodule
