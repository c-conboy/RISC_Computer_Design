module Reg32(D, Q, clk, clr, e);
 input [31:0] D;
 input clk;
 input clr;
 input e; 
 output reg [31:0] Q; 
 
 always @(*)
	if (clr) begin
		Q <= 0; 
	end else if(e) begin 
		Q <= D;
	end
endmodule