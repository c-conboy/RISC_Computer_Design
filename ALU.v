module ALU(input [0:31] A, B, input [4:0] op, output reg[0:63] C);

	wire [31:0] and_result, or_result, add_result, inc_result,  negate_result, sub_result, shift_right_result, shift_left_result, ror_result, rol_result, shra_result;
	wire add_carry_out, inc_carry_out, sub_carry_out;
	wire [63:0] mult_result, div_result;
	and_or and_instance(A, B, 1'b1, and_result);
	and_or or_instance(A, B, 1'b0, or_result);
	Add_rca_32 add_instance(add_carry_out, add_result, A, B, 1'b0);
	Add_rca_32 inc_instance(inc_carry_out, inc_result, B, 1, 1'b0);
	Sub_rca_32 sub_instance(sub_carry_out, sub_result, A, B, 1'b0);
	negate negate_instance(negate_result, B);
	shift_right shift_right_instance(shift_right_result, A, B);
	shift_left shift_left_instance(shift_left_result, A, B);
	ror ror_instance(ror_result, A, B);
	rol rol_instance(rol_result, A, B);
	shra shra_instance(shra_result, A, B);
	mult mult_instance(A, B, mult_result);
	div div_instance(A, B, div_result);
	
	
	always @(*) begin 
		case(op)
			0 : C = sign_extend(or_result);
			1 : C = sign_extend(and_result);
			2 : C = sign_extend(add_result);
			3 : C = sign_extend(sub_result);
			4 : C = sign_extend(negate_result);
			5 : C = sign_extend(shift_right_result);
			6 : C = sign_extend(shift_left_result);
			7 : C = sign_extend(ror_result);
			8 : C = sign_extend(rol_result);
			9 : C = sign_extend(shra_result);
			10 : C = mult_result;
			11 : C = div_result;
			12 : C = inc_result;
			13 : C = ~B;
			default : C = sign_extend(and_result);
		endcase
	end
	
	function [63:0] sign_extend(input [31:0] original_signal);
		case(original_signal[31])
			0 : sign_extend = {32'b0, original_signal};
			1 : sign_extend = {32'b11111111111111111111111111111111, original_signal};
		endcase
	endfunction

endmodule





