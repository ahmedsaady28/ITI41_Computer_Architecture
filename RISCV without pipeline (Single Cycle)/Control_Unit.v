`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:44:54 02/01/2021 
// Design Name: 
// Module Name:    Control_Unit 
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
module Control_Unit(instr,breq,brlt,pc_sel,a_sel,b_sel,mem_write_en,reg_file_wr_en,alu_sel,wb_sel,imm_sel,pr_un);
  input [31:0] instr;
  input breq,brlt;
  output reg pc_sel,a_sel,b_sel,mem_write_en,reg_file_wr_en,pr_un;
  output reg [3:0] alu_sel;
  output reg [1:0] wb_sel; 
  output reg [2:0] imm_sel;
  localparam add= 4'b0000;
  localparam sub= 4'b1000,
             or_c=4'b0110,
				 and_c=4'b0111;
  //reg [8:0] instr_sel;
  always@(*)
     begin 
	     //instr_sel={instr[30],instr[14:12],instr[6:2]};
		  #50			
	     case(instr[6:0])
          	  7'b0110011:begin  				  //add,sub,or,and
				            pc_sel=1'b0;
								a_sel=1'b0;
								b_sel=1'b0;
								mem_write_en=1'bx;
								reg_file_wr_en=1'b1;
								pr_un=1'bx;
								wb_sel=2'b01;
								alu_sel={instr[30],instr[14:12]};
								imm_sel=3'bx;
							end
				  7'b0010011:begin             //addi,andi,ori
				            pc_sel=1'b0;
								a_sel=1'b0;
								b_sel=1'b1;
								mem_write_en=1'b0;
								reg_file_wr_en=1'b1;
								pr_un=1'bx;
								wb_sel=2'b01;
								alu_sel={1'b0,instr[14:12]};
								imm_sel=3'b000;
								end
				  7'b0000011:begin              //lw
					         pc_sel=1'b0;
								a_sel=1'b0;
								b_sel=1'b1;
								mem_write_en=1'b0;
								reg_file_wr_en=1'b1;
								pr_un=1'bx;
								wb_sel=2'b0;
								alu_sel=add;								
								imm_sel=3'b000;
								end
				  7'b1100111:begin              //jalr
					         pc_sel=1'b1;
								a_sel=1'b0;
								b_sel=1'b0;
								mem_write_en=1'b0;
								reg_file_wr_en=1'b1;
								pr_un=1'bx;
								wb_sel=2'b10;
								alu_sel=add;
								imm_sel=3'b000;
								end
              7'b1100011:begin	           //beq bne
				            pc_sel=instr[12] ? !breq:breq;
								a_sel=1'b1;
								b_sel=1'b1;
								mem_write_en=1'b0;
								reg_file_wr_en=1'b0;
								pr_un=1'bx;
								wb_sel=2'bx;
								alu_sel=add;
								imm_sel=3'b001; 
								end
              7'b1101111:begin	           //jal
				            pc_sel=1'b1;
								a_sel=1'b1;
								b_sel=1'b1;
								mem_write_en=1'b0;
								reg_file_wr_en=1'b1;
								pr_un=1'bx;
								wb_sel=2'b10;
								alu_sel=add;
								imm_sel=3'b100;
								end
              7'b0100011:begin             //sw	
				            pc_sel=1'b0;
								a_sel=1'b0;
								b_sel=1'b1;
								mem_write_en=1'b1;
								reg_file_wr_en=1'b0;
								pr_un=1'bx;
								wb_sel=2'b0;
								alu_sel=add;
								imm_sel=3'b010;
								end
					
				
              default:begin 
				            pc_sel=1'b0;
								a_sel=1'bx;
								b_sel=1'bx;
								mem_write_en=1'bx;
								reg_file_wr_en=1'bx;
								pr_un=1'bx;
								wb_sel=1'bx;
								alu_sel=1'bx;
								imm_sel=1'bx;
								end
								endcase
                    		  
	   end

endmodule
