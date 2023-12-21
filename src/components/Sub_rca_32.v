module Sub_rca_32(output c_out, output[31:0]sum, input[31:0] a,b, input c_in);
	
	wire [31:0] nB;
	assign nB = (~b) + 1'b1; 
	wire				c_in16;
	Add_rca_16 M1	(c_in16,	sum[15:0],	a[15:0],	nB[15:0],	c_in);
	Add_rca_16 M2	(c_out,	sum[31:16],	a[31:16],nB[31:16], c_in16);
endmodule