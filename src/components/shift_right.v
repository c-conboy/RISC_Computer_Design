module shift_right(output reg [31:0] C, input [31:0] A, B);
	integer i; 
	always @(*) begin
		C[31] = 0;
		C[30:0] = A[31:1];
		for (i = 1; i < 32; i = i + 1) begin
			if(i < B)begin
				C[30:0] = C[31:1];
				C[31] = 0;
			end
		end
	end
endmodule