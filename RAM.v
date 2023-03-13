module RAM (input ReadS, WriteS, input [8:0] address, inout [31:0] Data);
	reg [31:0] mem [511:0];
	reg [31:0] temp_data; 

	always@(*)begin
		if(WriteS == 1)
			mem[address] <= Data; 
		else
			temp_data <= mem[address];
	end
	assign Data=ReadS?temp_data:32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
endmodule