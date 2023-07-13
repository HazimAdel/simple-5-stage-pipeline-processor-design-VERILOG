module Processor_CH(clk, reset, enable);
input clk, reset, enable;



// implementation details are left to the student
wire [31:0] pc, pcout, instrf,instrd,
            pc4f, pc4d, pc4x, pc4m, pc4w,
            exinstrd, exinstrx,
            readdata1d, readdata1x,
            readdata2d,readdata2x,readdata2m,Aalu, Balux, Balum,
            muxbalu,
            aluresx, aluresm, aluresw, exinstr32, baddr, selpc, jumpout,
            readdatam, readdataw, writedata;

wire [2:0]aluopd, aluopx; 
wire [1:0]regdstd, regdstx, memtoregd, memtoregx, memtoregm, memtoregw,ForwardA, ForwardB; 
wire alusrcd, alusrcx,
     regwrited, regwritex, regwritem, regwritew,
     memreadd, memreadx, memreadm,
     memwrited, memwritex, memwritem, 
     branch, jump, pcsrc, equal, band, flush, orflush; 

wire [27:0] instr28;
wire [4:0] writeregx, writeregm, writeregw, instrx25, instrx20, instrx15;


//ProgramCounter programcounter(Q, D, clk, reset, enable); 
ProgramCounter programcounter(pcout, pc, clk, reset, enable); 

//Instruction_Memory(PC, instruction); 
Instruction_Memory im(pcout, instrf);

//Adder32bit (out, a, b); for PC + 4 
Adder32bit adderpc4(pc4f, pcout, 32'h4);

//Mux_2_to_1_32bit(out, s, i1, i0); branch address or PC + 4 
Mux_2_to_1_32bit mpcsel(selpc, band, baddr, pc4f);

//Mux_2_to_1_32bit(out, s, i1, i0); jump address or jr 
Mux_2_to_1_32bit mjump(jumpout, jump,{pc4d[31:28],instr28} , readdata1d);

//Mux_2_to_1_32bit(out, s, i1, i0); select the final address 
Mux_2_to_1_32bit finaddr(pc, pcsrc, jumpout, selpc);


IFID ifid({pc4d,instrd}, {pc4f,instrf}, clk, orflush, enable);
//***************************************************************************************
//************************** End of First Stage (Fetch) ************************************************

//ControlUnit(aluop, ……, jump, pcsrc, opcode, func); 
ControlUnit cu(aluopd, alusrcd, regdstd, memtoregd, regwrited, memreadd, memwrited, branch, jump, pcsrc, instrd[31:26], instrd[5:0]); 

//ShiftLeft26_by2(out, in); 
ShiftLeft26_by2 sf26(instr28, instrd[25:0]); 

//SignExtend (out, in); 
SignExtend se(exinstrd, instrd[15:0]); 

//ShiftLeft32_by2(out, in); 
ShiftLeft32_by2 sf32(exinstr32, exinstrd);

//Adder32bit (out, a, b); to calculate branch target Address 
Adder32bit adderpcbranch(baddr, pc4d, exinstr32);

//RegFile(readdata1 ,readdata2, ………, clk, reset); 
RegFile rg(readdata1d ,readdata2d, instrd[25:21], instrd[20:16], writedata, writeregw, regwritew, clk, reset); 

//Comparator32bit (equal, a, b); 
Comparator32bit com32(equal, readdata1d, readdata2d); 

//AND (out, in1, in2); 
AND andbe(band, equal, branch); 

HazardDetectionUnit HDU(flush, pcsrc, band);
OR or1(orflush, flush, reset);

IDEX idex({regwritex,memtoregx,memwritex,memreadx,aluopx,regdstx,alusrcx,pc4x,readdata1x,readdata2x,exinstrx,instrx25,instrx20,instrx15}, {regwrited,memtoregd,memwrited,memreadd,aluopd,regdstd,alusrcd,pc4d,readdata1d,readdata2d,exinstrd,instrd[25:21],instrd[20:16],instrd[15:11]}, clk, reset, enable);
//***************************************************************************************
//************************** End of Second Stage (Decode) ************************************************

//Mux_3_to_1_5bit(out, s, i2, i1, i0); 
Mux_3_to_1_5bit mwritereg(writeregx, regdstx, 5'd31, instrx15, instrx20); 

//Mux_3_to_1_32bit(out, s, i2, i1, i0); 
Mux_3_to_1_32bit aluA(Aalu, ForwardA, writedata, aluresm, readdata1x);

//Mux_3_to_1_32bit(out, s, i2, i1, i0); 
Mux_3_to_1_32bit aluB(Balux, ForwardB, writedata, aluresm, readdata2x);

//Mux_2_to_1_32bit(out, s, i1, i0); for the input b of the ALU 
Mux_2_to_1_32bit malu(muxbalu, alusrcx, exinstrx, Balux);

//ALU_32(result, a, b, m); 
ALU_32 alu32(aluresx, Aalu, muxbalu, aluopx);

//ForwardingUnit(ForwardA, ForwardB, EXMEM_Rd, MEMWB_Rd, IDEX_Rs, IDEX_Rt, EXMEM_RegWrite, MEMWB_RegWrite)
ForwardingUnit fwd(ForwardA, ForwardB, writeregm, writeregw, instrx25, instrx20, regwritem, regwritew);

EXMEM exmem({regwritem,memtoregm,memwritem,memreadm,pc4m,aluresm,Balum,writeregm}, {regwritex,memtoregx,memwritex,memreadx,pc4x,aluresx,Balux,writeregx}, clk, reset, enable);
//***************************************************************************************
//************************** End of Third Stage (Execute) ************************************************

//Data_Memory(readdata , address, ……., clk ); 
Data_Memory dm(readdatam , aluresm, Balum, memwritem , memreadm , clk); 


MEMWB memwb({regwritew, memtoregw, pc4w, readdataw, aluresw, writeregw}, {regwritem, memtoregm, pc4m, readdatam, aluresm, writeregm}, clk, reset, enable);
//***************************************************************************************
//************************** End of Forth Stage (Memory) ************************************************

//Mux_3_to_1_32bit(out, s, i2, i1, i0); 
Mux_3_to_1_32bit wridata(writedata, memtoregw, pc4w, readdataw, aluresw); 

//***************************************************************************************
//************************** End of Fifth Stage (Write Back) ************************************************



endmodule
