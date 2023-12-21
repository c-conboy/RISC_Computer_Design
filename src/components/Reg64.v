module Reg64(D, Q, clk, clr, e);
 input [63:0] D;
 input clk;
 input clr;
 input e; 
 output reg [63:0] Q; 
 
 always @(*)
	if (clr) begin
		Q <= 0; 
	end else if(e) begin 
		Q <= D;
	end
endmodule