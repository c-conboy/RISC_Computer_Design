module MdMultiplexer (input [31:0] BusMuxOut, Mdatain, input Read, output reg [31:0] MdMuxOutput);

	always@(BusMuxOut or Mdatain or Read)
		begin
			if (Read == 1)
				MdMuxOutput = Mdatain;
			else
				MdMuxOutput = BusMuxOut; 
		end
endmodule