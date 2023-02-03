module shift_left(output [31:0] C, input [31:0] A);
	assign C[0] = 0;
	assign C[31:1] = A[30:0];
endmodule