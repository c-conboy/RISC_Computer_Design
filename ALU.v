module ALU(input [0:31] A, B, input [4:0] op, output reg[0:63] C);

	wire [31:0] and_result, or_result, add_result, add_carry_out, negate_result, sub_result, sub_carry_out, shift_right_result, shift_left_result, ror_result, rol_result, shra_result; 
	wire [63:0] mult_result;
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	Add_rca_32 add_instance(add_carry_out, add_result, A, B, 0);
	Sub_rca_32 sub_instance(sub_carry_out, sub_result, A, B, 0);
	negate negate_instance(negate_result, A);
	shift_right shift_right_instance(shift_right_result, A);
	shift_left shift_left_instance(shift_left_result, A);
	ror ror_instance(ror_result, A);
	rol rol_instance(rol_result, A);
	shra shra_instance(shra_result, A);
	mult mult_instance(A, B, mult_result);
	
	
	always @(*) begin 
		case(op)
			0 : begin
				 C = {32'b0, or_result};
				 end
			1 : begin
				 C = {32'b0, and_result};
				 end
			2 : begin
				 C = {32'b0, add_result};
				 end
			3 : begin
				 C = {32'b0, sub_result};
				 end
			4 : begin
				 C = {32'b0, negate_result};
				 end
			5 : begin
				 C = {32'b0, shift_right_result};
				 end
			6 : begin
				 C = {32'b0, shift_left_result};
				 end
			7 : begin
				 C = {32'b0, ror_result};
				 end
			8 : begin 
				 C = {32'b0, rol_result};
				 end
			9 : begin 
				 C = {32'b0, shra_result};
				 end
			10 : C = mult_result;
			default : C = and_result;
		endcase
	end

endmodule

