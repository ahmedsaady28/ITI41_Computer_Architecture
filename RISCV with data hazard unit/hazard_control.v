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
module hazard_control(inst_x,inst_m,inst_w,mux_a,mux_b
    );
	input [31:0] inst_x ,inst_m ,inst_w;
	output reg [1:0] mux_a,mux_b;

	always @(*)
		begin
		if  (inst_x[19:15] == 5'b0) mux_a = 2'b0;
		else if (inst_x[19:15] == inst_m [11:7])   mux_a = 2'b01 ; //rs1=rd
		else if (inst_x[19:15] == inst_w [11:7]) mux_a = 2'b10; //rs2 = rd
		else mux_a = 2'b0;
		
		
		if  (inst_x[19:15] == 5'b0) mux_b = 2'b0;
		else if (inst_x[24:20] == inst_m [11:7])   mux_b = 2'b01 ; //rs1=rd
		else if (inst_x[24:20] == inst_w [11:7]) mux_b = 2'b10; //rs2 = rd
		else mux_b = 2'b0;
		end
				
				
		
				
endmodule
