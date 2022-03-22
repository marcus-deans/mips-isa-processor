// module bit32_cla(sum,a,b,c_out, c_in);
//     // Inputs
//     input [31:0]a;
//     input [31:0]b;
//     input c[0];

//     // Outputs
//     output [31:0]sum;
//     output c_out;

//     // 
//     wire [4:0] c;
//     wire [3:0] p;
//     wire [3:0] g;

//     // initial condition for carry, allows symmetry of operation
//     assign c[0] = c_in;


//     // wire g[0],p[0],p0c0,c8,p0,g[1],p[1],p1g0,p1p0c0,p1,c16,g[2],p[2],p2g1,p2p1g0,p2p1p0c0,c24,g[3],p[3],p3g2,p3p2g1,p3p2p1p0c0,p3p2p1g0;
//     //first carrybit
//     wire w1;
//     bit8_cla alpha(sum[7:0],a[7:0],b[7:0],g[0],c[0],p[0]);
//     and c1_and1(w1,p[0],c[0]);
//     or c1_or1(c[1],g[0],w1);

//     bit8_cla bravo(sum[15:8],a[15:8],b[15:8],g[1],c[1],p[1]);
//     wire [1:0] w2;
//     and c2_and1(w2[0],p[1],g[0]);
//     and c2_and2(w2[1],p[1],p[0],c[0]);
//     or c2_or1(c[2],g[1],w2[0],w2[1]);

//     bit8_cla charlie(sum[23:16],a[23:16],b[23:16],g[2],c[2],p[2]);
//     wire [2:0] w3;
//     and c3_and1(w3[0],p[2],g[1]);
//     and c3_and2(w3[1],p[2],p[1],g[0]);
//     and c3_and3(w3[2],p[2],p[1],p[0],c[0]);
//     or c3_or1(c[3],g[2],w3[0],w3[1],w3[2]);

//     bit8_cla delta(sum[31:24],a[31:24],b[31:24],g[3],c[3],p[3]);
//     wire [3:0] w4;
//     and c4_and1(w4[0],p[2],g[1]);
//     and c4_and2(w4[1],p[3],p[2],g[1]);
//     and c4_and3(w4[2],p[3],p[2],p[1],g[0]);
//     and c4_and4(w4[3],p[3],p[2],p[1],p[0],c[0]);
//     or c4_or1(c[4],g[3],w4[0],w4[1],w4[2],w4[3]);

//     assign c_out = c[4];

// endmodule

module bit32_cla(S,A,B,Cout, cin);
  input [31:0]A;
  input [31:0]B;
  input cin;
  output [31:0]S;
  output Cout;
  wire G0,P0,p0c0,c8,p0,G1,P1,p1g0,p1p0c0,p1,c16,G2,P2,p2g1,p2p1g0,p2p1p0c0,c24,G3,P3,p3g2,p3p2g1,p3p2p1p0c0,p3p2p1g0;
  //first carrybit
  bit8_cla eight1(S[7:0],A[7:0],B[7:0],G0,cin,P0);
  and a1088(p0c0,P0,cin);
  or o18098(c8,G0,p0c0);
  bit8_cla eight2(S[15:8],A[15:8],B[15:8],G1,c8,P1);
  and a288(p1g0,P1,G0);
  and a7773(p1p0c0,P1,P0,cin);
  or o290987(c16,G1,p1g0,p1p0c0);
  bit8_cla eight3(S[23:16],A[23:16],B[23:16],G2,c16,P2);
  and a9895(p2g1,P2,G1);
  and a9862(p2p1g0,P2,P1,G0);
  and a78793(p2p1p0c0,P2,P1,P0,cin);
  or o28908(c24,G2,p2g1,p2p1g0,p2p1p0c0);
  bit8_cla  eight4(S[31:24],A[31:24],B[31:24],G3,c24,P3);
  and a76675(p3g2,P2,G1);
  and a5889(p3p2g1,P3,P2,G1);
  and a672(p3p2p1g0,P3,P2,P1,G0);
  and a8983(p3p2p1p0c0,P3,P2,P1,P0,cin);
  or o29090(Cout,G3,p3g2,p3p2g1,p3p2p1g0,p3p2p1p0c0);




endmodule