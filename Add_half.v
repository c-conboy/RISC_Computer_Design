module Add_half(output c_out_sum, input a,b)
	xor M1(sum, a, b);
	and M2(c_out, a, b);
endmodule
