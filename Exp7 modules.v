module ProgramCounter (Q,D,clk,reset,enable);
input clk,reset,enable ;
input  [31:0] D;
output [31:0] Q;
reg [31:0]Q;
   always @(posedge clk)
    begin
      #2;
      if (reset == 1)
        Q=32'b0;
      else if(enable == 1)
        Q=D;
    end

endmodule 
//////////////////////////////////////////////////////


module IFID (Q, D, clk, reset, enable);
input clk, reset, enable;
input [63:0] D;
output [63:0] Q;
reg [63:0]Q;
   always @(posedge clk)
    begin
      #2;
      if (reset == 1)
        Q=63'b0;
      else if(enable == 1)
        Q=D;
    end


endmodule
//////////////////////////////////////////////////////

module IDEX (Q, D, clk, reset, enable);
input clk, reset, enable;
input [153:0] D;
output [153:0] Q;
reg [153:0]Q;
   always @(posedge clk)
    begin
      #2;
      if (reset == 1)
        Q=153'b0;
      else if(enable == 1)
        Q=D;
    end


endmodule
//////////////////////////////////////////////////////

module EXMEM (Q, D, clk, reset, enable);
input clk, reset, enable;
input [105:0] D;
output [105:0] Q;
reg [105:0]Q;
   always @(posedge clk)
    begin
      #2;
      if (reset == 1)
        Q=105'b0;
      else if(enable == 1)
        Q=D;
    end

endmodule
//////////////////////////////////////////////////////

module MEMWB (Q, D, clk, reset, enable);
input clk, reset, enable;
input [103:0] D;
output [103:0] Q;
reg [103:0]Q;
   always @(posedge clk)
    begin
      #2;
      if (reset == 1)
        Q=103'b0;
      else if(enable == 1)
        Q=D;
    end


endmodule







