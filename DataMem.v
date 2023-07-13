//Name:Hazim Adel Issa
//ID:

module Data_Memory(readdata , address, writedata , memwrite , memread , clk); 
input [31:0] address , writedata ; 
input memwrite , memread , clk; 
output [31:0] readdata; 
reg [31:0] readdata;
reg [31:0] DM [255:0];
// implementation details are left to the student…… 
integer i;
initial begin 
  for(i=0;i<256;i=i+1)
      DM[i] = i;
  end
always @(memread or address)begin
  #10; if(memread==1)
      readdata  = DM[address>>2];
end
always @(posedge clk)begin
  #5; if(memwrite==1)
      DM[address>>2]= writedata;
     
end
endmodule 
