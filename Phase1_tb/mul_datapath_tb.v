`timescale 1ns/10ps
module mul_datapath_tb;
	reg PCout, Zlowout, Zhighout, MDRout, R6out, R7out; // add any other signals to see in your simulation
	reg MARin, Zin, PCin, MDRin, IRin, Yin, LOin, HIin;
	reg Read, R6in, R7in;
	reg [4:0] ALU_Control;
	reg Clock;
	reg [31:0] Mdatain;
	parameter 	Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
					Reg_load2b = 4'b0100, T0 = 4'b0101, T1 = 4'b0110, T2 = 4'b0111, T3 = 4'b1000, 
					T4 = 4'b1001, T5 = 4'b1010, T6 = 4'b1011;
	reg [3:0] Present_state = Default;
	
	Datapath DUT(.clk(Clock), .clr(1'b0), .PCout(PCout), .Zlowout(Zlowout), .MDRout(MDRout), 
	.MARin(MARin), .Zin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .Read(Read), 
	.OpCode(ALU_Control), .Mdatain(Mdatain),
	.R6in(R6in), .R7in(R7in), .HIin(HIin), .LOin(LOin),
	.R2out(1'b0), .R3out(1'b0),	
	.R0out(1'b0), .R1out(1'b0), .R4out(1'b0), .R5out(1'b0), .R6out(R6out), .R7out(R7out), 
	.R8out(1'b0), .R9out(1'b0), .R10out(1'b0), .R11out(1'b0), .R12out(1'b0), .R13out(1'b0), 
	.R14out(1'b0), .R15out(1'b0), .HIout(1'b0), .LOout(1'b0), .Zhighout(Zhighout)
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
			Reg_load2b : Present_state = T0;
			T0 : Present_state = T1;
			T1 : Present_state = T2;
			T2 : Present_state = T3;
			T3 : Present_state = T4;
			T4 : Present_state = T5;
			T5 : Present_state = T6;
	endcase
 end

always @(Present_state) // do the required job in each state
 begin
	case (Present_state) // assert the required signals in each clock cycle
			Default: begin
				PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout <= 0; // initialize the signals
				R6out <= 0; R7out <= 0; MARin <= 0; Zin <= 0;
				PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
				Read <= 0; ALU_Control <= 0; HIin <= 0; LOin <= 0;
				R6in <= 0; R7in <= 0; Mdatain <= 32'h00000000;
			end
	
			Reg_load1a: begin
				Mdatain <= 32'd13;
				Read = 0; MDRin = 0; // the first zero is there for completeness
				#1 Read <= 1; MDRin <= 1;
				#5 Read <= 0; MDRin <= 0;
			end
			
			Reg_load1b: begin
				#1 MDRout <= 1; R6in <= 1;
				#5 MDRout <= 0; R6in <= 0; // initialize R6 with the value $13
			end
			
			Reg_load2a: begin
				Mdatain <= 32'd5;
				#1 Read <= 1; MDRin <= 1;
				#5 Read <= 0; MDRin <= 0;
			end
			
			Reg_load2b: begin
				#1 MDRout <= 1; R7in <= 1;
				#5 MDRout <= 0; R7in <= 0; // initialize R7 with the value $5
			end
			
			
			T0: begin // see if you need to de-assert these signals
				#1 PCout <= 1; MARin <= 1; ALU_Control <= 12; Zin <= 1;//Inc PC
				#2 PCout <= 0; MARin <= 0; Zin <= 0;
			end
			
			T1: begin
				#1 Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
				Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
				#2 Zlowout <= 0; PCin <= 0;
			end
			
			T2: begin
				#1 MDRout <= 1; IRin <= 1;
				#2 MDRout <= 0; IRin <= 0;
			end
			
			T3: begin
				#1 R6out <= 1; Yin <= 1;
				#2 R6out <= 0; Yin <= 0;
			end
			
			T4: begin
				#1 R7out <= 1; ALU_Control <= 10; Zin <= 1;
				#2 R7out <= 0; Zin <= 0;
			end
			
			T5: begin
				#1 Zlowout <= 1; LOin <= 1;
				#2 Zlowout <= 0; LOin <= 0;
			end
			
			T6: begin
				#1 Zhighout <= 1; HIin <= 1;
				#2 Zhighout <= 0; HIin <= 0;
			end
	endcase
 end
endmodule 