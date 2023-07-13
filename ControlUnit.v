//Name:hazim 
//ID:

module ControlUnit(aluop, alusrc, regdst, memtoreg, regwrite,memread, memwrite, branch, jump, pcsrc, opcode, func); 
input [5:0] opcode, func; 
output [2:0]aluop; 
output [1:0]regdst, memtoreg; 
output alusrc, regwrite, memread, memwrite, branch, jump, pcsrc; 



//aluop
assign #4 aluop[0] = ~opcode[5] & ~opcode[4] & func[0] | ~opcode[5] & opcode[4] & opcode[0] | opcode[5] & ~opcode[4];
assign #4 aluop[1] = ~opcode[5] & ~opcode[4] & func[1] | ~opcode[5] & opcode[4] & opcode[1] | opcode[5] & ~opcode[4];
assign #4 aluop[2] = ~opcode[5] & ~opcode[4] & func[2] | ~opcode[5] & opcode[4] & opcode[2];

//regdst
assign #4 regdst[0] = ~opcode[5] & ~opcode[4];

assign #4 regdst[1] = opcode[5] & opcode[4] & opcode[1];
//memtoreg
assign #4 memtoreg[0] =  opcode[5] & ~opcode[4] & ~opcode[3];
assign #4 memtoreg[1] =  opcode[5] &  opcode[4] &  opcode[1];
//alusrc 
assign #4 alusrc = opcode[5] ^  opcode[4];

//regwrite
assign #4 regwrite = ~opcode[5] & ~opcode[4] & ~func[3] |
 opcode[5] & ~opcode[4]&~opcode[3]  | ~opcode[5] & opcode[4]  | opcode[5] & ~opcode[4] & ~opcode[3] |
  opcode[5] & opcode[4] & opcode[1];

//memread
assign #4 memread = opcode[5] & ~opcode[4] & ~opcode[3];

//memwrite
assign #4 memwrite = opcode[5] & ~opcode[4] & opcode[3];

//branch
assign #4 branch = opcode[5] & opcode[4] & ~opcode[0] & ~opcode[1];

//jump
assign #4 jump = opcode[5] & opcode[4] & opcode[0];

//pcsrc
assign #4 pcsrc = ~opcode[5] & ~opcode[4] & func[3] | opcode[5] & opcode[4] & opcode[0];

endmodule  
