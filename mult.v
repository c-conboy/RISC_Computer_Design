module mult(input[31:0]A,B, output[63:0]C);
	reg[32:0]tcM;
	
	wire[31:0]Q,M;
	assign Q = A;
	assign M = B;
	reg[0:2] cc[0:15];
	reg[0:63] pp[0:15];
	reg[0:63] spp[0:15];
	reg[0:63]prod;
	integer kk;
	integer i;
	
	always @(Q or M)
	begin
		tcM[32:0] = {~M[31],~M}+1;
		cc[0] = {Q[1],Q[0],1'b0};
		for(kk=1;kk<16;kk=kk+1)
		begin
			cc[kk] = {Q[2*kk+1], Q[2*kk], Q[2*kk-1]};
		end
		for(kk=0;kk<16;kk=kk+1)
		begin
			case(cc[kk])
				3'b001 , 3'b010 : pp[kk] = {M[31], M};
				3'b011 : pp[kk] = {M,1'b0};
				3'b100 : pp[kk] = {tcM[31:0],1'b0};
				3'b101 , 3'b110 : pp[kk] = tcM;
				default : pp[kk] = 0;
			endcase
			spp[kk][32:63] = pp[kk][32];
			spp[kk][0:31] = pp[kk][0:31];
			for(i=0;i<kk;i=i+1)
			begin
				spp[kk] <= spp[kk] << 2;
			end
		end
		prod = spp[0];
		for(kk=1;kk<16;kk=kk+1)
		begin 
			prod = prod + spp[kk];
		end
	end 

	assign C = prod;
	
endmodule
				
			
				
		
	