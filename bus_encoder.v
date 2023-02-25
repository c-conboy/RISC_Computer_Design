module bus_encoder(output reg [4:0] Code, input[31:0] Data);
	always @(Data or Code)
	begin
		if(Data == 32'b00000000000000000000000000000001)Code=0; else
		if(Data == 32'b00000000000000000000000000000010)Code=1; else
		if(Data == 32'b00000000000000000000000000000100)Code=2; else
		if(Data == 32'b00000000000000000000000000001000)Code=3; else
		if(Data == 32'b00000000000000000000000000010000)Code=4; else
		if(Data == 32'b00000000000000000000000000100000)Code=5; else
		if(Data == 32'b00000000000000000000000001000000)Code=6; else
		if(Data == 32'b00000000000000000000000010000000)Code=7; else
		if(Data == 32'b00000000000000000000000100000000)Code=8; else
		if(Data == 32'b00000000000000000000001000000000)Code=9; else
		if(Data == 32'b00000000000000000000010000000000)Code=10; else
		if(Data == 32'b00000000000000000000100000000000)Code=11; else
		if(Data == 32'b00000000000000000001000000000000)Code=12; else
		if(Data == 32'b00000000000000000010000000000000)Code=13; else
		if(Data == 32'b00000000000000000100000000000000)Code=14; else
		if(Data == 32'b00000000000000001000000000000000)Code=15; else
		if(Data == 32'b00000000000000010000000000000000)Code=16; else
		if(Data == 32'b00000000000000100000000000000000)Code=17; else
		if(Data == 32'b00000000000001000000000000000000)Code=18; else
		if(Data == 32'b00000000000010000000000000000000)Code=19; else
		if(Data == 32'b00000000000100000000000000000000)Code=20; else
		if(Data == 32'b00000000001000000000000000000000)Code=21; else
		if(Data == 32'b00000000010000000000000000000000)Code=22; else
		if(Data == 32'b00000000100000000000000000000000)Code=23; else
		if(Data == 32'b00000001000000000000000000000000)Code=24; else
		if(Data == 32'b00000010000000000000000000000000)Code=25; else
		if(Data == 32'b00000100000000000000000000000000)Code=26; else
		if(Data == 32'b00001000000000000000000000000000)Code=27; else
		if(Data == 32'b00010000000000000000000000000000)Code=28; else
		if(Data == 32'b00100000000000000000000000000000)Code=29; else
		if(Data == 32'b01000000000000000000000000000000)Code=30; else
		if(Data == 32'b10000000000000000000000000000000)Code=31; else Code = 5'bx;
	end
endmodule
		