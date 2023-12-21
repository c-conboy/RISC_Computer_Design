module bus_encoder(output reg [4:0] Code, input[31:0] Data);
	always @(Data or Code)
	begin
		if(Data[0])Code=0; else
		if(Data[1])Code=1; else
		if(Data[2])Code=2; else
		if(Data[3])Code=3; else
		if(Data[4])Code=4; else
		if(Data[5])Code=5; else
		if(Data[6])Code=6; else
		if(Data[7])Code=7; else
		if(Data[8])Code=8; else
		if(Data[9])Code=9; else
		if(Data[10])Code=10; else
		if(Data[11])Code=11; else
		if(Data[12])Code=12; else
		if(Data[13])Code=13; else
		if(Data[14])Code=14; else
		if(Data[15])Code=15; else
		if(Data[16])Code=16; else
		if(Data[17])Code=17; else
		if(Data[18])Code=18; else
		if(Data[19])Code=19; else
		if(Data[20])Code=20; else
		if(Data[21])Code=21; else
		if(Data[22])Code=22; else
		if(Data[23])Code=23; else
		if(Data[24])Code=24; else
		if(Data[25])Code=25; else
		if(Data[26])Code=26; else
		if(Data[27])Code=27; else
		if(Data[28])Code=28; else
		if(Data[29])Code=29; else
		if(Data[30])Code=30; else
		if(Data[31])Code=31; else Code = 5'bx;
	end
endmodule
		