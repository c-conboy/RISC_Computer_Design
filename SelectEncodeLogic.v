module SelectEncodeLogic (input [31:0] IRotp, input Gra, Grb, Grc, Rin, Rout, BAout, 
output reg [31:0] C_sign_extended, output reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, 
output reg R0out,R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out);

	reg [4:0] Rselect;
	
	
	always @ (IRotp or Rin or Rout or BAout)begin
		if(Gra)
			Rselect = IRotp[26:23];
		if(Grb)
			Rselect = IRotp[22:19];
		if(Grc)
			Rselect = IRotp[18:15];
			
		
		case(Rselect)
			0 : R0in = Rin; 
			1 : R1in = Rin;
			2 : R2in = Rin; 
			3 : R3in = Rin; 
			4 : R4in = Rin; 
			5 : R5in = Rin; 
			6 : R6in = Rin; 
			7 : R7in = Rin; 
			8 : R8in = Rin; 
			9 : R9in = Rin; 
			10 : R10in = Rin; 
			11 : R11in = Rin; 
			12 : R12in = Rin; 
			13 : R13in = Rin; 
			14 : R14in = Rin; 
			15 : R15in = Rin; 
			default : begin 
				R15in = 0;
				R14in = 0;
				R13in = 0;
				R12in = 0;
				R11in = 0;
				R10in = 0;
				R9in = 0;
				R8in = 0;
				R7in = 0;
				R6in = 0;
				R5in = 0;
				R4in = 0;
				R3in = 0;
				R2in = 0;
				R1in = 0;
				R0in = 0;
			end
		endcase
		
		
		
	
		case(Rselect)
			0 : R0out = Rout | BAout; 
			1 : R1out = Rout | BAout;
			2 : R2out = Rout | BAout; 
			3 : R3out = Rout | BAout; 
			4 : R4out = Rout | BAout; 
			5 : R5out = Rout | BAout; 
			6 : R6out = Rout | BAout; 
			7 : R7out = Rout | BAout; 
			8 : R8out = Rout | BAout; 
			9 : R9out = Rout | BAout; 
			10 : R10out = Rout | BAout; 
			11 : R11out = Rout | BAout; 
			12 : R12out = Rout | BAout; 
			13 : R13out = Rout | BAout; 
			14 : R14out = Rout | BAout; 
			15 : R15out = Rout | BAout; 
			default : begin 
				R15out = 0;
				R14out = 0;
				R13out = 0;
				R12out = 0;
				R11out = 0;
				R10out = 0;
				R9out = 0;
				R8out = 0;
				R7out = 0;
				R6out = 0;
				R5out = 0;
				R4out = 0;
				R3out = 0;
				R2out = 0;
				R1out = 0;
				R0out = 0;
			end
		endcase
		
		
		if(IRotp[17]) 
			C_sign_extended = {14'b11111111111111, IRotp[17:0]};
		else
			C_sign_extended = {14'b0, IRotp[17:0]};
	end
endmodule


