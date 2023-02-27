module RAM (input ReadS, WriteS, input [8:0] address, inout [31:0] Data);
	reg [31:0] mem [512];
	reg [31:0] temp_data;

	always@(*)begin
		if(WriteS == 1)begin
			mem[address] <= Data; 
		end else if(ReadS == 1)begin
			temp_data <= mem[address]; 
		end
	end

	assign Data = (ReadS==1)? temp_data : 32'hz;
endmodule