module test ; 
reg clk, reset, enable; 

 // implementation details are left to the student 
Processor_CH plp(clk, reset, enable);

initial begin : stop_at 
#3200 ; $finish ;
end 

initial begin : init 

reset=1 ; enable=1; clk =1;
#70 reset=0 ;

end
 
always #60 clk=~clk;

endmodule 

