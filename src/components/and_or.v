module and_or(input [0:31] A, B, input selection, output [0:31] result);

	assign result = (selection == 1)? A & B : A | B; 
	
endmodule