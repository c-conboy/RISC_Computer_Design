"# RISC_Computer_Design" 

Booth Algorihm Pseudocode


Booth Algorithm Pseudo-Code:


module mult(input [31:0] A, B, output [63:0] C);

assign inv_M = {~M[width-1],~M}+1; //generate two’s compiment of multiplicand x(M)
reg [31:0] A, Q, M;
Integer N = 32; (3 wide binary value?)
CC [31:0] bits of something

always @ (Q or M or inv_M)
begin
cc[0] = {Q[1],Q[0],1’b0}; //generate Ck for k=0(special case)
for(kk=1;kk<32;kk=kk+1)
 cc[kk] = {Q[2*kk+1],Q[2*kk],Q[2*kk-1]}; //generate Ck for each k, for k is not 0
for(kk=0;kk<32;kk=kk+1)
 begin
 case(cc[kk]) //Depending upon Ck, select M,2M,-M,-2M, or 0 as the partial product
 3’b001 , 3’b010 : pp[kk] = {M[width-1],M};// if one or 2 then pp = M 
 3’b011 : pp[kk] = {x,1’b0};// if 3 then pp = 2* M
 3’b100 : pp[kk] = {inv_x[width-1:0],1’b0};
 3’b101 , 3’b110 : pp[kk] = inv_x;
 default : pp[kk] = 0;
 endcase
 spp[kk] = $signed(pp[kk]);//sign extend
 for(ii=0;ii<kk;ii=ii+1)
 spp[kk] = {spp[kk],2’b00}; //multiply by 2 to the power x or shifting operation
 end //for(kk=0;kk<N;kk=kk+1)
 prod = spp[0];
 for(kk=1;kk<N;kk=kk+1)
 prod = prod + spp[kk]; //add partial products to get result
end
assign p = prod;
