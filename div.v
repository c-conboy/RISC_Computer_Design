module div(input[31:0]A,B, output[64:0]C);
	wire[31:0]Q,M;
	reg[31:0]Qp, Mp;
	assign Q = A;
	assign M = B;
	integer Qflag;
	integer Mflag;
	integer i;
	reg[64:0]AQ, AQs;
	
	always @(Q or M)
	begin
		
		Qp = Q;
		Mp = M;
		Qflag = 0;
		Mflag = 0;
		if(Q[31] == 1)
		begin
			Qflag = 1;
			Qp = ~Q+1;
		end
		
		if(M[31] == 1)
		begin
			Mflag = 1;
			Mp = ~M+1;
		end
		
		AQ[64:0] = {33'b0, Qp};
		
		for(i=0; i<32; i=i+1)
		begin
			AQs = shift_left(AQ);
			if(AQs[64] == 0)
			begin
				AQs[64:32] = AQs[64:32]+~Mp;
			end
			
			else 
			begin
				AQs[64:32] = AQs[64:32]+Mp;
			end
			
			if(AQs[64]==1)
			begin
				AQs[0] = 0;
			end
			
			else
			begin
				AQs[0] = 1;
			end
		end
		
		if(AQs[64] == 1)
		begin
		AQs[64:32] = AQs[64:32] + Mp;
		end
		
		if(Mflag == 1)
		begin
			AQs[64:32] = ~AQs[64:32]+1;
		end
		if(Qflag == 1)
		begin
			AQs[31:0] = ~AQs[31:0]+1;
		end
		
		
			
	end
	assign C = AQs;
	function [64:0] shift_left(input [64:0] Z);
		begin
		shift_left[0] = 0;
		shift_left[64:1] = Z[63:0];
		end
	endfunction
endmodule

	
	