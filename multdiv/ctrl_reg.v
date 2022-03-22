module ctrl_reg(clock, in, in_enable, out);
    input clock, in, in_enable;
    output out;

    dffe_ref dffe_ctrl(out, in, clock, in_enable, 1'b0);
    
endmodule