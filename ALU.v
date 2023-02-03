module ALU(input [0:31] A, B, input [4:0] op, output reg[0:31] C);

	wire [31:0] and_result, or_result, add_result, add_carry_out, negate_result, sub_result, sub_carry_out, shift_right_result, shift_left_result; 
	
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	Add_rca_32 add_instance(add_carry_out, add_result, A, B, 0);
	Sub_rca_32 sub_instance(sub_carry_out, sub_result, A, B, 0);
	negate negate_instance(negate_result, A);
	shift_right shift_right_instance(shift_right_result, A);
	shift_left shift_left_instance(shift_left_result, A);
	
	
	always @(*) begin 
		case(op)
			0 : C = or_result;
			1 : C = and_result;
			2 : C = add_result;
			3 : C = sub_result;
			4 : C = negate_result;
			5 : C = shift_right_result;
			6 : C = shift_left_result;
			default : C = and_result;
		endcase
	end

endmodule

