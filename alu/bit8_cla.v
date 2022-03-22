module bit8_cla(sum,a,b,c_out, c_in,p_out);
    //input
    input [7:0]a;
    input [7:0]b;
    input c_in;
    // outputs
    output c_out;
    output p_out;
    output [7:0]sum;
    
    // carries, propagate, generate
    wire c_out;
    wire [8:0] c;
    wire [7:0] p;
    wire [7:0] g;

    // initial condition for carry, allows symmetry of operation
    assign c[0] = c_in;

    //first carrybit
    wire w1;
    or c1_or1(p[0],a[0],b[0]); // p[0]
    and c1_and1(w1,p[0],c[0]); //p0c0
    and c1_and2(g[0],a[0],b[0]); //g[0]
    or c1_or2(c[1],g[0],w1);

    //second
    wire [1:0] w2;
    or c2_or1(p[1],a[1],b[1]);
    and c2_and1(g[1],a[1],b[1]);
    and c2_and2(w2[0],p[1],g[0]);
    and c2_and3(w2[1],p[1],p[0],c[0]);
    or c2_or2(c[2],g[1], w2[0],w2[1]);

    //third
    wire [2:0] w3;
    or c3_or1(p[2],a[2],b[2]);
    and c3_and1(g[2],a[2],b[2]);
    and c3_and2(w3[0],p[2],g[1]);
    and c3_and3(w3[1],p[2],p[1],g[0]);
    and c3_and4(w3[2],p[2],p[1],p[0],c[0]);
    or c3_or2(c[3],g[2],w3[0], w3[1],w3[2]);

    //fourth
    wire [3:0] w4;
    or c4_or1(p[3],a[3],b[3]);
    and c4_and1(g[3],a[3],b[3]);
    and c4_and2(w4[0],p[3],g[2]);
    and c4_and3(w4[1],p[3],p[2],g[1]);
    and c4_and4(w4[2],p[3],p[2],p[1],g[0]);
    and c4_and5(w4[3],p[3],p[2],p[1],p[0],c[0]);
    or c4_or2(c[4],g[3],w4[0],w4[1], w4[2],w4[3]);


    //fifth
    wire [4:0] w5;
    or c5_or1(p[4],a[4],b[4]);
    and c5_and1(g[4],a[4],b[4]);
    and c5_and2(w5[0],p[4],g[3]);
    and c5_and3(w5[1],p[4],p[3],g[2]);
    and c5_and4(w5[2],p[4],p[3],p[2],g[1]);
    and c5_and5(w5[3],p[4],p[3],p[2],p[1],g[0]);
    and c5_and6(w5[4],p[4],p[3],p[2],p[1],p[0],c[0]);
    or c5_or2(c[5],g[4],w5[0],w5[1],w5[2], w5[3],w5[4]);

    //sixth
    wire [5:0] w6;
    or c6_or1(p[5],a[5],b[5]);
    and c6_and1(g[5],a[5],b[5]);
    and c6_and2(w6[0],p[5],g[4]);
    and c6_and3(w6[1],p[5],p[4],g[3]);
    and c6_and4(w6[2],p[5],p[4],p[3],g[2]);
    and c6_and5(w6[3],p[5],p[4],p[3],p[2],g[1]);
    and c6_and6(w6[4],p[5],p[4],p[3],p[2],p[1],g[0]);
    and c6_and7(w6[5],p[5],p[4],p[3],p[2],p[1],p[0],c[0]);
    or c6_or2(c[6],g[5],w6[0],w6[1],w6[2],w6[3],w6[4],w6[5]);

    //seventh
    wire [6:0] w7;
    or c7_or1(p[6],a[6],b[6]);
    and c7_and1(g[6],a[6],b[6]);
    and c7_and2(w7[0],p[6],g[5]);
    and c7_and3(w7[1],p[6],p[5],g[4]);
    and c7_and4(w7[2],p[6],p[5],p[4],g[3]);
    and c7_and5(w7[3],p[6],p[5],p[4],p[3],g[2]);
    and c7_and6(w7[4],p[6],p[5],p[4],p[3],p[2],g[1]);
    and c7_and7(w7[5],p[6],p[5],p[4],p[3],p[2],p[1],g[0]);
    and c7_and8(w7[6],p[6],p[5],p[4],p[3],p[2],p[1],p[0],c[0]);
    or c7_or2(c[7],g[6],w7[0],w7[1],w7[2],w7[3],w7[4],w7[5],w7[6]);


    //eighth
    wire [7:0] w8;
    or c8_or1(p[7],a[7],b[7]);
    and c8_and1(g[7],a[7],b[7]);
    and c8_and2(w8[0],p[7],g[6]);
    and c8_and3(w8[1],p[7],p[6],g[5]);
    and c8_and4(w8[2],p[7],p[6],p[5],g[4]);
    and c8_and5(w8[3],p[7],p[6],p[5],p[4],g[3]);
    and c8_and6(w8[4],p[7],p[6],p[5],p[4],p[3],g[2]);
    and c8_and7(w8[5],p[7],p[6],p[5],p[4],p[3],p[2],g[1]);
    and c8_and8(w8[6],p[7],p[6],p[5],p[4],p[3],p[2],p[1],g[0]);
    or c8_or2(c[8],g[7],w8[0],w8[1],w8[2],w8[3],w8[4],w8[5],w8[6]);

    // perform constituent one-bit adds for each operation
    xor bit1(sum[0],a[0],b[0],c[0]);
    xor bit2(sum[1],a[1],b[1],c[1]);
    xor bit3(sum[2],a[2],b[2],c[2]);
    xor bit4(sum[3],a[3],b[3],c[3]);
    xor bit5(sum[4],a[4],b[4],c[4]);
    xor bit6(sum[5],a[5],b[5],c[5]);
    xor bit7(sum[6],a[6],b[6],c[6]);
    xor bit8(sum[7],a[7],b[7],c[7]);

    and p_out_and(p_out,p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7]);

    assign c_out = c[8];

endmodule
