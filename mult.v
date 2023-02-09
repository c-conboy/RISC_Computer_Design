module mult(input[31:0]A,B, output[63:0]C);
	
	reg[32:0]tcM;
	wire[31:0]Q,M;
	assign Q = A;
	assign M = B;
	reg[2:0] cc[15:0];
	reg[63:0] pp[15:0];
	reg[63:0] spp[15:0];
	reg[63:0]prod;
	integer kk;
	integer i;
	
	always @(Q or M)
	begin
		kk = 0;
		i = 0;
		tcM[32:0] = {~M[31],~M}+1;
		cc[0] = {Q[1],Q[0],1'b0};
		for(kk=1;kk<16;kk=kk+1)
		begin
			cc[kk] = {Q[2*kk+1], Q[2*kk], Q[2*kk-1]};
		end
		for(kk=0;kk<16;kk=kk+1)
		begin
			case(cc[kk])
				3'b001 : pp[kk] = {M[31], M};
				3'b010 : pp[kk] = {M[31], M};
				3'b011 : pp[kk] = {M,1'b0};
				3'b100 : pp[kk] = {tcM[31:0],1'b0};
				3'b101 : pp[kk] = tcM;
				3'b110 : pp[kk] = tcM;
				default : pp[kk] = 0;
			endcase
			spp[kk] = sign_extend(pp[kk]);
			for(i=0;i<kk;i=i+1)
			begin
				spp[kk] = spp[kk] <<< 2;
			end
		end 
		
		prod = spp[0][63:0];
		for(kk=1;kk<15;kk=kk+1)
		begin
			prod = prod + spp[kk][63:0];
		end
		
	end 

	assign C = prod;
	
	function [63:0] sign_extend(input [63:0] original_signal);
		begin
			case(original_signal[32])
				0 : sign_extend = {32'b0, original_signal[31:0]};
				1 : sign_extend = {32'b11111111111111111111111111111111, original_signal[31:0]};
			endcase
		end
	endfunction
endmodule
				
			
				
		
	