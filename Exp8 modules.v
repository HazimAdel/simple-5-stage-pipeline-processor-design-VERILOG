module Comparator5bit (equal, a, b);
input [4:0]a, b;
output equal;
wire [5:0]w;
XNOR x0(w[0], a[0], b[0]);
XNOR x1(w[1], a[1], b[1]);
XNOR x2(w[2], a[2], b[2]);
XNOR x3(w[3], a[3], b[3]);
XNOR x4(w[4], a[4], b[4]);
AND4 a0(w[5], w[4], w[3], w[2], w[1]);
AND a1(equal, w[0], w[5]);
endmodule 

//////////////////////////////////////////////////////


module ForwardingUnit(ForwardA, ForwardB, EXMEM_Rd, MEMWB_Rd, IDEX_Rs, IDEX_Rt, EXMEM_RegWrite, MEMWB_RegWrite);
input [4:0] EXMEM_Rd, MEMWB_Rd, IDEX_Rs, IDEX_Rt;
input EXMEM_RegWrite, MEMWB_RegWrite;
output [1:0]ForwardA, ForwardB;
wire w0,w1,w2,w3,w4,w5,w6,w7;
//forward A[0]
Comparator5bit c0(w0, EXMEM_Rd, IDEX_Rs);
OR8 o0(w1, EXMEM_Rd[0], EXMEM_Rd[1], EXMEM_Rd[2], EXMEM_Rd[3], EXMEM_Rd[4], 1'b0,1'b0,1'b0);
AND3 a0(ForwardA[0], w0, w1, EXMEM_RegWrite);
//**********************************************************************************
//forward A[1]
Comparator5bit c1(w2, MEMWB_Rd, IDEX_Rs);
OR8 o1(w3, MEMWB_Rd[0], MEMWB_Rd[1], MEMWB_Rd[2], MEMWB_Rd[3], MEMWB_Rd[4], 1'b0,1'b0,1'b0);
INV inv1(w4, ForwardA[0]);
AND4 a1(ForwardA[1], w2, w3,w4, MEMWB_RegWrite);
//**********************************************************************************
//forward B[0]
Comparator5bit c2(w5, EXMEM_Rd, IDEX_Rt);
AND3 a2(ForwardB[0], w5, w1, EXMEM_RegWrite);
//**********************************************************************************
//forward B[1]
Comparator5bit c3(w6, MEMWB_Rd, IDEX_Rt);
INV inv3(w7, ForwardB[0]);
AND4 a3(ForwardB[1], w6, w3,w7, MEMWB_RegWrite);
endmodule

//////////////////////////////////////////////////////









