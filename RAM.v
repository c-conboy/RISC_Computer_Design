module RAM (input ReadS, WriteS, input [8:0] address, inout [31:0] Data);
	reg [31:0] mem [511:0];
	reg [31:0] temp_data;

	always@(*)begin
		if(WriteS == 1)begin
			mem[address] <= Data; 
		end
	end
	assign Data=ReadS?mem[address]:32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
endmodule