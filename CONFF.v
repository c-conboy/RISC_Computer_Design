module CONFF (input [1:0] C2, input [31:0] BusMuxOut, output ConRegInput); 
	wire busOut= ~| BusMuxOut; 
	//Equal to Zero
	and(izi, busOut, !C2[1], !C2[0]);
	//Non Zero 
	and(nzi, ~busOut, !C2[1], C2[0]);
	//If Positive
	and(ipi, !BusMuxOut[31], C2[1], !C2[0]);
	//If Negative 
	and(ini, BusMuxOut[31], C2[1], C2[0]);
	or(ConRegInput, izi, nzi, ipi, ini);
	
endmodule