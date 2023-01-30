module ALU(input [0:31] A, B, input [4:0] op, output reg[0:31] result);

	wire [31:0] and_result, or_result; 
	
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	
	always @(*) begin 
		case(op)
			0 : result = or_result;
			1 : result = and_result;
			default : result = and_result;
		endcase
	end

endmodule

