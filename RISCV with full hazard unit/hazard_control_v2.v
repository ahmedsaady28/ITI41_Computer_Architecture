`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:09:00 02/09/2021 
// Design Name: 
// Module Name:    hazard_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module hazard_control_v2(inst_x,inst_m,inst_w,mux_a,mux_b,pcsel_in_x,pcsel_in_m,pcsel_in_w,pcsel_out,regw_in,regw_out,dmemw_in,dmemw_out
    );
	 
	input [31:0] inst_x ,inst_m ,inst_w;
	input        pcsel_in_m,pcsel_in_x,pcsel_in_w,regw_in,dmemw_in;
	output reg [1:0] mux_a,mux_b;
	output reg       pcsel_out,dmemw_out,regw_out;

	always @(*)
		begin
		if  (inst_x[19:15] == 5'b0) mux_a = 2'b0;
		else if (inst_x[19:15] == inst_m [11:7])   mux_a = 2'b01 ; //rs1=rd
		else if (inst_x[19:15] == inst_w [11:7]) mux_a = 2'b10; //rs2 = rd
		else mux_a = 2'b0;
		
		
		if  (inst_x[24:20] == 5'b0) mux_b = 2'b0;
		else if (inst_x[24:20] == inst_m [11:7])   mux_b = 2'b01 ; //rs1=rd
		else if (inst_x[24:20] == inst_w [11:7]) mux_b = 2'b10; //rs2 = rd
		else mux_b = 2'b0;
		
		
		if (pcsel_in_m == 1'b1 || pcsel_in_w == 1'b1)
			begin
			pcsel_out = 1'b0;
			regw_out   = 1'b0;
			dmemw_out  = 1'b0;
			end
		else
			begin
			pcsel_out  = pcsel_in_x;
			regw_out   = regw_in;
			dmemw_out  = dmemw_in;	
			end
		end
		
				
				
		
				
endmodule
