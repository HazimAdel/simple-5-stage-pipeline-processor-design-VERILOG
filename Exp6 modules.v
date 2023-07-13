//Name:hazim adel
//ID:


module Adder32bit (out, a, b); 
input [31:0]a, b; 
output [31:0]out; 

// implementation details are left to the student …… 
assign #50 out = a + b;

endmodule 

//////////////////////////////////////////////////////

module SignExtend (out, in); 
input [15:0]in; 
output [31:0]out; 
reg [31:0] out;
// implementation details are left to the student …… 
always @(in)begin
  if (in[15]==0)
      begin
      out = {16'h0,in};
      end
  else 
      begin
      out = {16'hffff,in};
      end
end

endmodule 

//////////////////////////////////////////////////////

module Comparator32bit (equal, a, b); 
input [31:0]a, b; 
output equal; 
reg equal;
// implementation details are left to the student …… 
always @(a or b)begin
  if(a==b)
     begin
     #10 equal = 1;
     end
  else
     begin
     #10 equal = 0;
     end
end

endmodule 

//////////////////////////////////////////////////////

module ShiftLeft26_by2(out, in); 
input [25:0]in; 
output [27:0]out; 

// implementation details are left to the student …… 
assign out = in <<2;

endmodule 

//////////////////////////////////////////////////////

module ShiftLeft32_by2(out, in); 
input [31:0]in; 
output [31:0]out; 

// implementation details are left to the student …… 
assign out = in<<2;

endmodule 

//////////////////////////////////////////////////////

module Mux_3_to_1_5bit(out, s, i2, i1, i0); 
input [4:0] i2, i1, i0; 
input [1:0]s; 
output [4:0]out; 
reg [4:0] out;
// implementation details are left to the student …… 
always @(i0 or i1 or i2 or s) begin
     #6 case (s)
            2'b00: out = i0;
            2'b01: out = i1;
            2'b10: out = i2;
        endcase
    end
endmodule 

//////////////////////////////////////////////////////

module Mux_3_to_1_32bit(out, s, i2, i1, i0); 
input [31:0] i2, i1, i0; 
input [1:0]s; 
output [31:0]out; 
reg [31:0] out;
// implementation details are left to the student …… 
always @(i0 or i1 or i2 or s) begin
     #6 case (s)
            2'b00: out = i0;
            2'b01: out = i1;
            2'b10: out = i2;
        endcase
    end
endmodule 

//////////////////////////////////////////////////////

module Mux_2_to_1_32bit(out, s, i1, i0); 
input [31:0] i1, i0; 
input s; 
output [31:0]out; 
reg [31:0] out;
// implementation details are left to the student …… 
always @(i0 or i1 or s) begin
     #6 case (s)
            2'b00: out = i0;
            2'b01: out = i1;
        endcase
    end
endmodule 





