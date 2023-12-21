module negate(output [31:0] C, input [31:0] A);
	assign C = (~A) + 1'b1; 
endmodule