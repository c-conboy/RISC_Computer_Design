module shift_left(output reg [31:0] C, input [31:0] A, B);
	integer i; 
	always @(*) begin
		C[0] = 0;
		C[31:1] = A[30:0];
		for (i = 1; i < 32; i = i + 1) begin
			if(i < B)begin
				C[31:1] = C[30:0];
				C[0] = 0;
			end
		end
	end
endmodule