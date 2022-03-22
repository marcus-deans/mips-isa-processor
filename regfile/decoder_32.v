module decoder_32(write_regite_reg, enable, out);
    input [4:0] write_regite_reg;
    input enable;
    output [31:0] out;

    wire [31:0] shifter_in;
    assign shifter_in = enable ? 32'b1 : 32'b0;

    left_barrel_shifter decoder(shifter_in, write_regite_reg, out);


    // input [4:0] write_reg;
    // input enable;

    // output [31:0] out;

    // // assign out = enable << write_reg;
    // // wire [31:0] shifter_in;

    // wire [31:0] validated;
    // wire [4:0] n_write_reg;

    // not NOT_0(n_write_reg[0], write_reg[0]);
    // not NOT_1(n_write_reg[1], write_reg[1]);
    // not NOT_2(n_write_reg[2], write_reg[2]);
    // not NOT_3(n_write_reg[3], write_reg[3]);
    // not NOT_4(n_write_reg[4], write_reg[4]);

    // and decode0_gate(out[0], n_write_reg[4], n_write_reg[3], n_write_reg[2], n_write_reg[1], n_write_reg[0]);
    // and decode1_gate(out[1], n_write_reg[4], n_write_reg[3], n_write_reg[2], n_write_reg[1], write_reg[0]);

    // and decode2_gate(out[2], n_write_reg[4], n_write_reg[3], n_write_reg[2], write_reg[1], n_write_reg[0]);
    // and decode3_gate(out[3], n_write_reg[4], n_write_reg[3], n_write_reg[2], write_reg[1], write_reg[0]);

    // and decode4_gate(out[4], n_write_reg[4], n_write_reg[3], write_reg[2], n_write_reg[1], n_write_reg[0]);
    // and decode5_gate(out[5], n_write_reg[4], n_write_reg[3], write_reg[2], n_write_reg[1], write_reg[0]);
    // and decode6_gate(out[6], n_write_reg[4], n_write_reg[3], write_reg[2], write_reg[1], n_write_reg[0]);
    // and decode7_gate(out[7], n_write_reg[4], n_write_reg[3], write_reg[2], write_reg[1], write_reg[0]);

    // and decode8_gate(out[8], n_write_reg[4], write_reg[3], n_write_reg[2], n_write_reg[1], n_write_reg[0]);
    // and decode9_gate(out[9], n_write_reg[4], write_reg[3], n_write_reg[2], n_write_reg[1], write_reg[0]);
    // and decode10_gate(out[10], n_write_reg[4], write_reg[3], n_write_reg[2], write_reg[1], n_write_reg[0]);
    // and decode11_gate(out[11], n_write_reg[4], write_reg[3], n_write_reg[2], write_reg[1], write_reg[0]);
    // and decode12_gate(out[12], n_write_reg[4], write_reg[3], write_reg[2], n_write_reg[1], n_write_reg[0]);
    // and decode13_gate(out[13], n_write_reg[4], write_reg[3], write_reg[2], n_write_reg[1], write_reg[0]);
    // and decode14_gate(out[14], n_write_reg[4], write_reg[3], write_reg[2], write_reg[1], n_write_reg[0]);
    // and decode15_gate(out[15], n_write_reg[4], write_reg[3], write_reg[2], write_reg[1], write_reg[0]);
    
    // and decode16_gate(out[16], write_reg[4], n_write_reg[3], n_write_reg[2], n_write_reg[1], n_write_reg[0]);
    // and decode17_gate(out[17], write_reg[4], n_write_reg[3], n_write_reg[2], n_write_reg[1], write_reg[0]);

    // and decode18_gate(out[18], write_reg[4], n_write_reg[3], n_write_reg[2], write_reg[1], n_write_reg[0]);
    // and decode19_gate(out[19], write_reg[4], n_write_reg[3], n_write_reg[2], write_reg[1], write_reg[0]);

    // and decode20_gate(out[20], write_reg[4], n_write_reg[3], write_reg[2], n_write_reg[1], n_write_reg[0]);
    // and decode21_gate(out[21], write_reg[4], n_write_reg[3], write_reg[2], n_write_reg[1], write_reg[0]);
    // and decode22_gate(out[22], write_reg[4], n_write_reg[3], write_reg[2], write_reg[1], n_write_reg[0]);
    // and decode23_gate(out[23], write_reg[4], n_write_reg[3], write_reg[2], write_reg[1], write_reg[0]);
    
    // and decode24_gate(out[24], write_reg[4], write_reg[3], n_write_reg[2], n_write_reg[1], n_write_reg[0]);
    // and decode25_gate(out[25], write_reg[4], write_reg[3], n_write_reg[2], n_write_reg[1], write_reg[0]);
    // and decode26_gate(out[26], write_reg[4], write_reg[3], n_write_reg[2], write_reg[1], n_write_reg[0]);
    // and decode27_gate(out[27], write_reg[4], write_reg[3], n_write_reg[2], write_reg[1], write_reg[0]);
    // and decode28_gate(out[28], write_reg[4], write_reg[3], write_reg[2], n_write_reg[1], n_write_reg[0]);
    // and decode29_gate(out[29], write_reg[4], write_reg[3], write_reg[2], n_write_reg[1], write_reg[0]);
    // and decode30_gate(out[30], write_reg[4], write_reg[3], write_reg[2], write_reg[1], n_write_reg[0]);
    // and decode31_gate(out[31], write_reg[4], write_reg[3], write_reg[2], write_reg[1], write_reg[0]);
endmodule