module Datapath2 (
		//INPUTS
		input clk, clr,
		input HIin, HIout, LOin, LOout, PCin, PCout, 
		IRin, Zin, Zhighout, Zlowout, Yin, MARin, MDRin, MDRout, Read, Write,
		input MBIout,
		input [31:0] manualBusInput,
		input [4:0] OpCode,
		input Gra, Grb, Grc, Rin, Rout, BAout, CONin, OutportIn
		//OUTPUTS
		//output [31:0] R0otp, R1otp, R2otp, R3otp, R4otp, R5otp, R6otp, R7otp, R8otp, R9otp, R10otp, R11otp, R12otp, R13otp, R14otp, R15otp, HIotp, LOotp, IRotp, BusMuxOutotp, Zotp, MARotp
		);
		 
	//Make wires for all the wires (connections that arent inputs)
	wire [31:0] BusMuxIn_R0, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Zhigh, 
	BusMuxIn_Zlow, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_Port, BusMuxOut, 
	MdMuxOutput, Y_output;
	wire [63:0] ALU_Output;
	
	//For reg 1:15
	wire [31:0] BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, 
	BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, 
	BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15; 
	
	//For Bus Encoder Mux Connection
	wire [4:0] Bus_Encoder_Output;
	
	//MAR Output to RAM (Address)
	wire [31:0] MARotp;
	
	//Stuff for select and encode
	wire [31:0] C_sign_extended;
	wire [15:0] RegInSelect;
	wire [15:0] RegOutSelect;

	//Intantiate Select and encode logic
	SelectEncodeLogic SEL (IRotp, Gra, Grb, Grc, Rin, Rout, BAout, 
	C_sign_extended, RegInSelect, RegOutSelect);
	
	//Instantiate all the registers
	Reg32 R0(BusMuxOut, R0otp, clk, clr, RegInSelect[0]);
	and (BusMuxIn_R0, !BAout, R0otp); 
	Reg32 R1(BusMuxOut, BusMuxIn_R1, clk, clr, RegInSelect[1]);
	Reg32 R2(BusMuxOut, BusMuxIn_R2, clk, clr, RegInSelect[2]);
	Reg32 R3(BusMuxOut, BusMuxIn_R3, clk, clr, RegInSelect[3]);
	Reg32 R4(BusMuxOut, BusMuxIn_R4, clk, clr, RegInSelect[4]);
	Reg32 R5(BusMuxOut, BusMuxIn_R5, clk, clr, RegInSelect[5]);
	Reg32 R6(BusMuxOut, BusMuxIn_R6, clk, clr, RegInSelect[6]);
	Reg32 R7(BusMuxOut, BusMuxIn_R7, clk, clr, RegInSelect[7]);
	Reg32 R8(BusMuxOut, BusMuxIn_R8, clk, clr, RegInSelect[8]);
	Reg32 R9(BusMuxOut, BusMuxIn_R9, clk, clr, RegInSelect[9]);
	Reg32 R10(BusMuxOut, BusMuxIn_R10, clk, clr, RegInSelect[10]);
	Reg32 R11(BusMuxOut, BusMuxIn_R11, clk, clr, RegInSelect[11]);
	Reg32 R12(BusMuxOut, BusMuxIn_R12, clk, clr, RegInSelect[12]);
	Reg32 R13(BusMuxOut, BusMuxIn_R13, clk, clr, RegInSelect[13]);
	Reg32 R14(BusMuxOut, BusMuxIn_R14, clk, clr, RegInSelect[14]);
	Reg32 R15(BusMuxOut, BusMuxIn_R15, clk, clr, RegInSelect[15]);
	
	//HI LO
	Reg32 HI(BusMuxOut, BusMuxIn_HI, clk, clr, HIin);
	Reg32 LO(BusMuxOut, BusMuxIn_LO, clk, clr, LOin);
	
	//Program Counter and Instruction Register
	Reg32 PC(BusMuxOut, BusMuxIn_PC, clk, clr, PCin);
	Reg32 IR(BusMuxOut, IRotp, clk, clr, IRin);
	
	//Memory Registers
	Reg32 MDR(MdMuxOutput, BusMuxIn_MDR, clk, clr, MDRin);
	Reg32 MAR(MdMuxOutput, MARotp, clk, clr, MARin);
	MdMultiplexer MMUX(BusMuxOut, BusMuxIn_MDR, Read, MdMuxOutput); 
	
	//ALU + ALU Registers
	Reg32 Y(BusMuxOut, Y_output, clk, clr, Yin);
	Reg64 Z(ALU_Output, {BusMuxIn_Zhigh, BusMuxIn_Zlow}, clk, clr, Zin);
	ALU ALU (Y_output, BusMuxOut, OpCode, ALU_Output); 
	
	//Instantiate the bus (encoder, multiplexer)
	bus_encoder Bus_Encoder (Bus_Encoder_Output, {7'b0, MBIout, Cout, InPortOut, MDRout, PCout, 
	Zlowout, Zhighout, LOout, HIout, RegOutSelect[15], RegOutSelect[14], RegOutSelect[13], RegOutSelect[12], 
	RegOutSelect[11], RegOutSelect[10], RegOutSelect[9], RegOutSelect[8], RegOutSelect[7], 
	RegOutSelect[6], RegOutSelect[5], RegOutSelect[4], RegOutSelect[3], 
	RegOutSelect[2], RegOutSelect[1], RegOutSelect[0]});
	bus_multiplexer Bus_Multiplexer (BusMuxOut, BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, 
	BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, 
	BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Zhigh, BusMuxIn_Zlow, 
	BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_Port, C_sign_extended, manualBusInput, Bus_Encoder_Output);
	
	//Memory Chip Interface (RAM)
	RAM RAM(Read, Write, MARotp[8:0], BusMuxIn_MDR);
	
	//Conditional Branch Logic
	CONFF CONFF(IRotp[20:19], BusMuxOut, ConRegInput);
	Reg32 CON (ConOtp, {31'b0, ConRegInput}, clk, clr, CONin);
	
	//INPUT OUTPUT PORTS
	Reg32 InPort (Input, BusMuxIn_Port, clk, clr, StrobeEnable);
	Reg32 OutPort (BusMuxOut, Output, clk, clr, OutPortIn);

	
	
endmodule