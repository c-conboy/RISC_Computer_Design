module rol(output reg [31:0]C, input [31:0]A,B);
	integer i; 
	reg temp;
	always @(*) begin
		C[0] = A[31];
		C[31:1] = A[30:0];
		for (i = 1; i < 32; i = i + 1) begin
			if(i < B)begin
				temp = C[31];
				C[31:1] = C[30:0];
				C[0] = temp;
			end
		end
	end
endmodule
