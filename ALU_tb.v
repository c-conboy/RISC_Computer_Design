`timescale 1ns/10ps
module ALU_tb;

	reg[31:0] input_a, input_b;
	reg[4:0] opcode;
	
	wire[0:63] ALU_result;
	
	ALU ALU_instance(input_a, input_b, opcode, ALU_result);
	
	initial
		begin
			input_a <= 2;
			input_b <= 3;
			opcode <= 0;
			
		#50 
			opcode <= 1;
		#50
			input_a <= 12;
			input_b <= 17;
			opcode <= 2;
		#25
			input_a <= 17;
			input_b <= 20;
			opcode <= 3;
		#25
			input_a <= 17;
			input_b <= 17;
			opcode <= 4;
		#25
			input_a <= 17;
			input_b <= 17;
			opcode <= 5;
		#25
			input_a <= 17;
			input_b <= 17;
			opcode <= 6;
		#25
			input_a <= 17;
			input_b <= 17;
			opcode <= 7;
		#25
			input_a <= 17;
			input_b <= 17;
			opcode <= 8;
		#25
			input_a <= 17;
			input_b <= 17;
			opcode <= 9;
		#25
			input_a <= 17;
			input_b <= 17;
			opcode <= 10;
		end
	
endmodule
