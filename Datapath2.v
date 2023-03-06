module Datapath2 (
		//INPUTS
		input clk, clr,
		input HIin, HIout, LOin, LOout, PCin, PCout, 
		IRin, Zin, Zhighout, Zlowout, Yin, MARin, MDRin, MDRout, Read, Write, Cout,
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
	MdMuxOutput, Y_output, IRotp;
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
	wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in; 
	wire R0out,R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out; 
	SelectEncodeLogic SEL (IRotp, Gra, Grb, Grc, Rin, Rout, BAout, 
	C_sign_extended, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
	R0out,R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out);
	
	wire [31:0] R0otp; 
	//Instantiate all the registers
	Reg32 R0(BusMuxOut, R0otp, clk, clr, R0in);
	assign BusMuxIn_R0 = !BAout & R0otp;
	Reg32 R1(BusMuxOut, BusMuxIn_R1, clk, clr, R1in);
	Reg32 R2(BusMuxOut, BusMuxIn_R2, clk, clr, R2in);
	Reg32 R3(BusMuxOut, BusMuxIn_R3, clk, clr, R3in);
	Reg32 R4(BusMuxOut, BusMuxIn_R4, clk, clr, R4in);
	Reg32 R5(BusMuxOut, BusMuxIn_R5, clk, clr, R5in);
	Reg32 R6(BusMuxOut, BusMuxIn_R6, clk, clr, R6in);
	Reg32 R7(BusMuxOut, BusMuxIn_R7, clk, clr, R7in);
	Reg32 R8(BusMuxOut, BusMuxIn_R8, clk, clr, R8in);
	Reg32 R9(BusMuxOut, BusMuxIn_R9, clk, clr, R9in);
	Reg32 R10(BusMuxOut, BusMuxIn_R10, clk, clr, R10in);
	Reg32 R11(BusMuxOut, BusMuxIn_R11, clk, clr, R11in);
	Reg32 R12(BusMuxOut, BusMuxIn_R12, clk, clr, R12in);
	Reg32 R13(BusMuxOut, BusMuxIn_R13, clk, clr, R13in);
	Reg32 R14(BusMuxOut, BusMuxIn_R14, clk, clr, R14in);
	Reg32 R15(BusMuxOut, BusMuxIn_R15, clk, clr, R15in);
	
	//HI LO
	Reg32 HI(BusMuxOut, BusMuxIn_HI, clk, clr, HIin);
	Reg32 LO(BusMuxOut, BusMuxIn_LO, clk, clr, LOin);
	
	//Program Counter and Instruction Register
	Reg32 PC(BusMuxOut, BusMuxIn_PC, clk, clr, PCin);
	Reg32 IR(BusMuxOut, IRotp, clk, clr, IRin);
	
	//Memory Registers
	wire [31:0] MDRotp; 
	Reg32 MDR(MdMuxOutput, MDRotp, clk, clr, MDRin);
	assign BusMuxIn_MDR = Read?32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz:MDRotp;
	Reg32 MAR(MdMuxOutput, MARotp, clk, clr, MARin);
	MdMultiplexer MMUX(BusMuxOut, BusMuxIn_MDR, Read, MdMuxOutput); 
	
	//ALU + ALU Registers
	Reg32 Y(BusMuxOut, Y_output, clk, clr, Yin);
	Reg64 Z(ALU_Output, {BusMuxIn_Zhigh, BusMuxIn_Zlow}, clk, clr, Zin);
	ALU ALU (Y_output, BusMuxOut, OpCode, ALU_Output); 
	
	//Instantiate the bus (encoder, multiplexer)
	bus_encoder Bus_Encoder (Bus_Encoder_Output, {7'b0, MBIout, Cout, InPortOut, MDRout, PCout, 
	Zlowout, Zhighout, LOout, HIout, R15out, R14out, R13out, R12out, 
	R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, 
	R2out, R1out, R0out});
	bus_multiplexer Bus_Multiplexer (BusMuxOut, BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, 
	BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, 
	BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Zhigh, BusMuxIn_Zlow, 
	BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_Port, C_sign_extended, manualBusInput, Bus_Encoder_Output);
	
	//Memory Chip Interface (RAM)
	RAM RAM(Read, Write, MARotp[8:0], BusMuxIn_MDR);
	
	//Conditional Branch Logic
	CONFF CONFF(IRotp[20:19], BusMuxOut, ConRegInput);
	Reg32 CON (ConOtp, ConRegInput, clk, clr, CONin);
	
	//INPUT OUTPUT PORTS
	Reg32 InPort (Input, BusMuxIn_Port, clk, clr, StrobeEnable);
	Reg32 OutPort (BusMuxOut, Output, clk, clr, OutPortIn);

	
	
endmodule