`timescale 1ns/10ps
module ram_datapath_tb;
	reg PCout, Zlowout, MDRout, R1out, MBIout; // add any other signals to see in your simulation
	reg MARin, Zin, PCin, MDRin, IRin, Yin;
	reg Read, Write, R1in, R0in;
	reg [4:0] ALU_Control;
	reg Clock;
	reg [31:0] manualBusInput; 
	parameter 	Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
					Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
					T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
	reg [3:0] Present_state = Default;
	
	Datapath DUT(.clk(Clock), .clr(1'b0), .PCout(PCout), .Zlowout(Zlowout), .MDRout(MDRout), 
	.MARin(MARin), .Zin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .Read(Read), .Write(Write),
	.OpCode(ALU_Control), .manualBusInput(manualBusInput),
	.R1in(R1in), .R0in(R0in),
	.R2out(1'b0), .R3out(1'b0), .MBIout(MBIout), 	
	.R0out(1'b0), .R1out(R1out), .R4out(1'b0), .R5out(1'b0), .R6out(1'b0), .R7out(1'b0), 
	.R8out(1'b0), .R9out(1'b0), .R10out(1'b0), .R11out(1'b0), .R12out(1'b0), .R13out(1'b0), 
	.R14out(1'b0), .R15out(1'b0), .HIout(1'b0), .LOout(1'b0), .Zhighout(1'b0)
	);
	// add test logic here
	initial
		begin
			Clock = 0;
			forever #10 Clock = ~ Clock;
		end
		
always @(posedge Clock) // finite state machine; if clock rising-edge
 begin
	case (Present_state)
			Default : Present_state = Reg_load1a;
			Reg_load1a : Present_state = Reg_load1b;
			Reg_load1b : Present_state = Reg_load2a;
			Reg_load2a : Present_state = Reg_load2b;
			Reg_load2b : Present_state = Reg_load3a;
			Reg_load3a : Present_state = Reg_load3b;
			Reg_load3b : Present_state = T0;
			T0 : Present_state = T1;
			T1 : Present_state = T2;
			T2 : Present_state = T3;
			T3 : Present_state = T4;
			T4 : Present_state = T5;
	endcase
 end

always @(Present_state) // do the required job in each state
 begin
	case (Present_state) // assert the required signals in each clock cycle
			Default: begin
				PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
				R1out <= 0; MARin <= 0; Zin <= 0;
				PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
				Read <= 0; ALU_Control <= 0; MBIout <= 0; 
				R0in <= 0; R1in <= 0; manualBusInput <= 32'h00000000;
			end
	
			Reg_load1a: begin//Load MAR ADDRESS for Write
				manualBusInput <= 32'd0;
				#1 MBIout <= 1; MARin <= 1;
				#5 MBIout <= 0; MARin <= 0;
			end
			
			Reg_load1b: begin//Put number into MDR then write to memory
				manualBusInput <= 32'd12;
				#1 MDRin <= 1; Read <= 0; MBIout <= 1; Write = 1;
				#5 MDRin <= 0; Read <= 0; MBIout <= 0; Write = 0;
			end
			
			Reg_load2a: begin//Read from RAM to R1
				#1 Read <= 1; MDRin <= 1; 
				#1 Read <= 0; MDRin <= 0; 
				#1 MDRout <= 1; R1in <= 1;
				#3 MDRout <= 0; R1in <= 0;
			end
			
			Reg_load2b: begin//Load Manual onto MAR
				manualBusInput <= 32'd1;
				#1 MBIout <= 1; MARin <= 1;
				#5 MBIout <= 0; MARin <= 0;
			end
			
			Reg_load3a: begin//Load R1 onto MAR at 1
				#1 MDRin <= 1; Read <= 0; R1out <= 1; Write = 1;
				#5 MDRin <= 0; Read <= 0; MBIout <= 0; Write = 0;
			end
			
			Reg_load3b: begin
			end
			
			T0: begin // see if you need to de-assert these signals
			end
			
			T1: begin
			end
			
			T2: begin
			end
			
			T3: begin
			end
			
			T4: begin
			end
			
			T5: begin
			end
	endcase
 end
endmodule 