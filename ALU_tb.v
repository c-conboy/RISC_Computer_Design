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
			input_b <= 17;
			opcode <= 3;
		end
	
endmodule
