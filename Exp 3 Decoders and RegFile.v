//Name:Hazim
//ID:

module Decoder2to4 (out, in, enable); 
input enable; 
input [1:0]in; 
output [3:0]out; 
wire w0,w1;
// implementation details are left to the student…… 
INV inv1(w0,in[0]);
INV inv2(w1,in[1]);
AND3 a0(out[0],enable,w0,w1);
AND3 a2(out[1],enable,in[0],w1);
AND3 a1(out[2],enable,w0,in[1]);
AND3 a3(out[3],enable,in[0],in[1]);
endmodule 

///////////////////////////////////////////////////////////////////

module Decoder3to8 (out, in, enable); 
input enable; 
input [2:0]in; 
output [7:0]out; 
wire w0,w1,w2;
// implementation details are left to the student…… 
INV inv1(w0,in[0]);
INV inv2(w1,in[1]);
INV inv3(w2,in[2]);
AND4 a0(out[0],enable,w0,w1,w2);
AND4 a1(out[1],enable,in[0],w1,w2);
AND4 a2(out[2],enable,w0,in[1],w2);
AND4 a4(out[3],enable,in[0],in[1],w2);

AND4 a3(out[4],enable,w0,w1,in[2]);


AND4 a6(out[5],enable,in[0],w1,in[2]);
AND4 a5(out[6],enable,w0,in[1],in[2]);
AND4 a7(out[7],enable,in[0],in[1],in[2]);
endmodule 

///////////////////////////////////////////////////////////////////

module Decoder5to32 (out, in, enable); 
input enable; 
input [4:0]in; 
output [31:0]out; 
wire [3:0]w;
// implementation details are left to the student……  
Decoder2to4 d24(w, in[4:3], enable);
Decoder3to8 d1(out[7:0], in[2:0], w[0]); 
Decoder3to8 d2(out[15:8], in[2:0], w[1]); 
Decoder3to8 d3(out[23:16], in[2:0], w[2]); 
Decoder3to8 d4(out[31:24], in[2:0], w[3]); 
endmodule 

///////////////////////////////////////////////////////////////////

module RegFile(readdata1 ,readdata2, readreg1, readreg2, writedata, writereg, regwrite, clk, reset); 
input regwrite, clk, reset; 
input [4:0]readreg1, readreg2, writereg; 
input [31:0]writedata; 
output [31:0]readdata1, readdata2; 
wire [31:0]w;
wire [31:0] out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15,out16,out17,out18,out19,out20,out21,out22,out23,out24,out25,out26,out27,out28,out29,out30,out31;
// implementation details are left to the student …… 

Decoder5to32 d532(w, writereg, regwrite);

REG32negclk r0(out0, writedata, clk, reset, 1'd0);
REG32negclk r1(out1, writedata, clk, reset, w[1]);
REG32negclk r2(out2, writedata, clk, reset, w[2]);
REG32negclk r3(out3, writedata, clk, reset, w[3]);
REG32negclk r4(out4, writedata, clk, reset, w[4]);
REG32negclk r5(out5, writedata, clk, reset, w[5]);
REG32negclk r6(out6, writedata, clk, reset, w[6]);
REG32negclk r7(out7, writedata, clk, reset, w[7]);

REG32negclk r8(out8, writedata, clk, reset, w[8]);
REG32negclk r9(out9, writedata, clk, reset, w[9]);
REG32negclk r10(out10, writedata, clk, reset, w[10]);
REG32negclk r11(out11, writedata, clk, reset, w[11]);
REG32negclk r12(out12, writedata, clk, reset, w[12]);
REG32negclk r13(out13, writedata, clk, reset, w[13]);
REG32negclk r14(out14, writedata, clk, reset, w[14]);
REG32negclk r15(out15, writedata, clk, reset, w[15]);

REG32negclk r16(out16, writedata, clk, reset, w[16]);
REG32negclk r17(out17, writedata, clk, reset, w[17]);
REG32negclk r18(out18, writedata, clk, reset, w[18]);
REG32negclk r19(out19, writedata, clk, reset, w[19]);
REG32negclk r20(out20, writedata, clk, reset, w[20]);
REG32negclk r21(out21, writedata, clk, reset, w[21]);
REG32negclk r22(out22, writedata, clk, reset, w[22]);
REG32negclk r23(out23, writedata, clk, reset, w[23]);

REG32negclk r24(out24, writedata, clk, reset, w[24]);
REG32negclk r25(out25, writedata, clk, reset, w[25]);
REG32negclk r26(out26, writedata, clk, reset, w[26]);
REG32negclk r27(out27, writedata, clk, reset, w[27]);
REG32negclk r28(out28, writedata, clk, reset, w[28]);
REG32negclk r29(out29, writedata, clk, reset, w[29]);
REG32negclk r30(out30, writedata, clk, reset, w[30]);
REG32negclk r31(out31, writedata, clk, reset, w[31]);


Mux_32_to_1_32bit m1(readdata1, readreg1, {out31,out30,out29,out28,out27,out26,out25,out24,out23,out22,out21,out20,out19,out18,out17,out16,out15,out14,out13,out12,out11,out10,out9,out8,out7,out6,out5,out4,out3,out2,out1,out0}); 
Mux_32_to_1_32bit m2(readdata2, readreg2, {out31,out30,out29,out28,out27,out26,out25,out24,out23,out22,out21,out20,out19,out18,out17,out16,out15,out14,out13,out12,out11,out10,out9,out8,out7,out6,out5,out4,out3,out2,out1,out0}); 

endmodule 







