module CONFF (input [1:0] C2, input [31:0] BusMuxOut, output reg [31:0] ConRegInput); 
	always @ (*) begin
		case (C2)
			0 : begin
				if(BusMuxOut == 0)
					ConRegInput = {31'b0, 1'b1};
				else
					ConRegInput = {31'b0, 1'b0};
			end
			1 : begin
				if(BusMuxOut != 0)
					ConRegInput = {31'b0, 1'b1};
				else
					ConRegInput = {31'b0, 1'b0};
			end
			2 : ConRegInput = {31'b0, !BusMuxOut[31]}; 
			3 : ConRegInput = {31'b0, BusMuxOut[31]};
			default : ConRegInput = {31'b0, 1'b0};
		endcase
	end	
endmodule