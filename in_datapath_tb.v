`timescale 1ns/10ps
module in_datapath_tb;
	reg PCout, Zlowout, MDRout, MBIout; // add any other signals to see in your simulation
	reg MARin, Zin, PCin, MDRin, IRin, Yin;
	reg Read, Write;
	reg Gra, Grb, Grc, Rin, Rout, BAout, CONin, OutportIn, Cout, InPortOut, StrobeEnable;
	reg [4:0] ALU_Control;
	reg Clock;
	reg [31:0] manualBusInput, Input; 
	parameter 	Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
					Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
					T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
	reg [3:0] Present_state = Default;
	
	Datapath2 DUT(.clk(Clock), .clr(1'b0), .PCout(PCout), .Zlowout(Zlowout), .MDRout(MDRout), 
	.MARin(MARin), .Zin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .Read(Read), .Write(Write),
	.OpCode(ALU_Control), .manualBusInput(manualBusInput),
	.MBIout(MBIout),  .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), 
	.BAout(BAout), .CONin(CONin), .OutportIn(OutportIn), .Cout(Cout), .InPortOut(InPortOut), .StrobeEnable(StrobeEnable), .Input(Input)
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
			T5 : Present_state = T6;
			T6 : Present_state = T7;

	endcase
 end

always @(Present_state) // do the required job in each state
 begin
	case (Present_state) // assert the required signals in each clock cycle
			Default: begin
				PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
				MARin <= 0; Zin <= 0; Gra <= 0; Grb <= 0; Grc <= 0;
				BAout <= 0; CONin <= 0; OutportIn <= 0; Cout <= 0;
				PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
				Read <= 0; ALU_Control <= 0; MBIout <= 0; 
				Rin <= 0; Rout <= 0; manualBusInput <= 32'h00000000; Write <= 0; 
			end
	
			Reg_load1a: begin//Load Onto PC, putm into MAR 
				manualBusInput <= 32'd0;
				#1 MBIout <= 1; PCin <= 1; MARin <= 1;
				#5 MBIout <= 0; PCin <= 0; MARin <= 0;
			end
			
			Reg_load1b: begin//Put Insturction into MDR at Zero, then load to IR so that we can put something into R1 using Grb
				manualBusInput <= 32'hB1800000;
				#1 MDRin <= 1; Read <= 0; MBIout <= 1; Write = 1;
				#2 MDRin <= 0; Read <= 0; MBIout <= 0; Write = 0;
				#1 IRin <= 1; MDRout <=  1;
				#2 IRin <= 0; MDRout <=  0;
			end
			
			Reg_load2a: begin  
			end
			
			Reg_load2b: begin
			end 
			
			Reg_load3a: begin // 
				Input <= 32'd2;
				#1 StrobeEnable <= 1;
				#5 StrobeEnable <= 0;
			end
			
			Reg_load3b: begin//REsassert MAR and IR to undeifned to ensure legit test
			end
			
			T0: begin //Load PC on MAR, Load PC+1 onto Z
				#1 PCout <= 1; MARin <= 1; ALU_Control <= 12; Zin <= 1;
				#2 PCout <= 0; MARin <= 0; Zin <= 0;
			end
			
			T1: begin //Load Z(PC +1) onto PC, read instruction from Mem[PC] into MDR 
				#2 Zlowout <= 1; PCin <= 1; 
				#2 Zlowout <= 0; PCin <= 0;
				#2 Read <= 1;
				#2 MDRin <= 1; 
				#2 Read <= 0; MDRin <= 0; 
			end
			
			T2: begin//Load MDR (insturction in Hex) onto IR
				#1 IRin <= 1; MDRout <=  1;
				#2 IRin <= 0; MDRout <=  0;
			end
			
			T3: begin
				#1 Gra <= 1; Rin <= 1; InPortOut <= 1;
				#2 Gra <= 0; Rin <= 0; InPortOut <= 0;
			end 
		endcase
	end
endmodule
		