`timescale 1ns/10ps
module ALU_tb;

	reg[31:0] input_a, input_b;
	reg[4:0] opcode;
	
	wire[31:0] ALU_result;
	
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
		#50
			input_a <= 17;
			input_b <= 20;
			opcode <= 3;
		#50
			input_a <= 17;
			input_b <= 17;
			opcode <= 4;
		#50
			input_a <= 17;
			input_b <= 17;
			opcode <= 5;
		#50
			input_a <= 17;
			input_b <= 17;
			opcode <= 6;
		#50
			input_a <= 17;
			input_b <= 17;
			opcode <= 7;
		#50
			input_a <= 17;
			input_b <= 17;
			opcode <= 8;
		#50
			input_a <= 17;
			input_b <= 17;
			opcode <= 9;
		end
	
endmodule
