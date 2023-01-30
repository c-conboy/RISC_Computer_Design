module ALU(input [0:31] A, B, input [4:0] op, output reg[0:31] C);

	wire [31:0] and_result, or_result, add_result, add_carry_out; 
	
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	Add_rca_32 add_instance(add_carry_out, add_result, A, B, 0);
	
	always @(*) begin 
		case(op)
			0 : C = or_result;
			1 : C = and_result;
			2 : C = add_result;
			default : C = and_result;
		endcase
	end

endmodule

