module bus_multiplexer(output reg [31:0] BusMuxOut, input [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Zhigh, BusMuxIn_Zlow, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_Port, C_sign_extended, manualBusInput, input [4:0] Code);
		always @(*)
		begin
			case(Code)
				0: BusMuxOut = BusMuxIn_R0;
				1: BusMuxOut = BusMuxIn_R1;
				2: BusMuxOut = BusMuxIn_R2;
				3: BusMuxOut = BusMuxIn_R3;
				4: BusMuxOut = BusMuxIn_R4;
				5: BusMuxOut = BusMuxIn_R5;
				6: BusMuxOut = BusMuxIn_R6;
				7: BusMuxOut = BusMuxIn_R7;
				8: BusMuxOut = BusMuxIn_R8;
				9: BusMuxOut = BusMuxIn_R9;
				10: BusMuxOut = BusMuxIn_R10;
				11: BusMuxOut = BusMuxIn_R11;
				12: BusMuxOut = BusMuxIn_R12;
				13: BusMuxOut = BusMuxIn_R13;
				14: BusMuxOut = BusMuxIn_R14;
				15: BusMuxOut = BusMuxIn_R15;
				16: BusMuxOut = BusMuxIn_HI; 
				17: BusMuxOut = BusMuxIn_LO; 
				18: BusMuxOut =BusMuxIn_Zhigh; 
				19: BusMuxOut =BusMuxIn_Zlow; 
				20: BusMuxOut =BusMuxIn_PC; 
				21: BusMuxOut =BusMuxIn_MDR; 
				22: BusMuxOut =BusMuxIn_Port;
				23: BusMuxOut = C_sign_extended;
				24: BusMuxOut = manualBusInput;
				default: BusMuxOut = BusMuxIn_R0;
			endcase
		end
endmodule
