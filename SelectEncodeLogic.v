module SelectEncodeLogic (input [31:0] IRotp, input Gra, Grb, Grc, Rin, Rout, BAout, 
output reg [31:0] C_sign_extended, output [15:0] RinArr, RoutArr);

	and(Graout, Gra, IRotp[26:23]);
	and(Grbout, Grb, IRotp[22:19]);
	and(Grcout, Grc, IRotp[18:15]);
	or(Rselect, Graout, Grbout, Grcout); 
	and(RinArr[Rselect], Rin, 1);
	or(RoutArr[Rselect], BAout, Rout);
	
	always @ (IRotp)begin
		if(IRotp[18]) begin 
			C_sign_extended = {13'b1111111111111, IRotp[18:0]};
		end else
			C_sign_extended = {13'b0, IRotp[18:0]};
	end
endmodule


