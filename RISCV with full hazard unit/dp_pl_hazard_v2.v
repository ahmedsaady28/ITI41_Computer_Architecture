`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:47:05 02/02/2021 
// Design Name: 
// Module Name:    top_dp 
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
module dp_pl_hazard_v2(dp_rst,dp_clk,pl_inst,dp_pcsel,dp_pcsel_m,dp_pcsel_w,dp_pcsel_hz_out,dp_immsel,dp_regwen_hz_in,dp_regwen_hz_out,dp_regwen_in,dp_dmemw_in,dp_dmemw_out,dp_brun,dp_brlt,dp_breq,dp_bsel,dp_asel,dp_alusel,dp_wbsel,dp_dmem_out,dp_imem_inst,dp_pc_next,dp_alu_out,dp_datab
    );
///////////////////////////////////////////////////////////////////////////////////Ports Declaration section///////////////////////////////////////////////////////////
///////////////////////////////////////Control logic ports/////////////////////// 
       //////////////////////////////////inputs///////////////////////////
	input         dp_pcsel,dp_pcsel_m,dp_pcsel_w   ;      //pc_mux select
	input  [2:0]  dp_immsel                        ;      //Imm. gen control
	input         dp_regwen_in                     ;      //reg file control bit
	input         dp_brun                          ;      //Comparator sign control bit
	input         dp_asel,dp_bsel                  ;      //ALU input muxes selectors
	input  [3:0]  dp_alusel                        ;      //alu mode sel
	input  [1:0]  dp_wbsel                         ;      //selectory for wbmux
       /////////////////////////////////outputs//////////////////////////
	output        dp_brlt,dp_breq                  ;      //output from the branch comparator
	output [31:0]	  pl_inst				           ;
	output         dp_pcsel_hz_out					  ;
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////Instruction memory ports////////////////////////
       //////////////////////////////////inputs///////////////////////////
	input  [31:0] dp_imem_inst                     ;      //Instruction from Imem
       /////////////////////////////////outputs//////////////////////////
	output [31:0] dp_pc_next                       ;      //Addr to the Imem
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////Data memory ports///////////////////////////////
       //////////////////////////////////inputs///////////////////////////
	input  [31:0]  dp_dmem_out                     ;      //Dmem output to wb mux
	input         dp_dmemw_in		                 ;
       /////////////////////////////////outputs//////////////////////////
	output [31:0]  dp_alu_out,dp_datab             ;      //Port connected to the Dmem address
	output         dp_dmemw_out                   ;
//////////////////////////////////////////////////////////////////////////////////


	input dp_regwen_hz_in;
   output dp_regwen_hz_out;	
//////////////////////////////////Global ports////////////////////////////////////
	input dp_clk,dp_rst;
//////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////End of section////////////////////////////////////////////////////////////////////////
	
	
///////////////////////////////////////////////////////////////////////////////////Internal wires and regs section///////////////////////////////////////////////////////
	wire [31:0] alu_out,pc_4,pcmux_out,pc_next   ;      
	wire [31:0] data_a,data_b,imm_gen_out        ;      //reg file O/Ps and the immediate gen. block
	wire [31:0] alu_in1,alu_in2                  ;      //ALU inputs
	wire [31:0] wb                               ;      //write back signal
///////////////////////////////////////////////////////////////////////////////////End of section////////////////////////////////////////////////////////////////////////
		
///////////////////////////////////////////////////////////////////////////////////Combinational section/////////////////////////////////////////////////////////////////
	assign dp_pc_next= pc_next                   ;      //sets the wire to connect to the imem addr. port
	assign dp_alu_out=alum_out_reg               ;      //sets the wire to connect to the dmem addr. port
	assign dp_datab=rs2m_out_reg                 ;      //sets the wire to connect to the dmem data  port
	assign pl_inst = instx_out_reg					;
	assign dp_pcsel_hz_out =pcsel_hz             ;
///////////////////////////////////////////////////////////////////////////////////End of section////////////////////////////////////////////////////////////////////////
	
///////////////////////////////////////////////////////////////////////////////////regs wires///////////////////////////////////////////////////////////////////////////
wire [31:0] instd_out_reg;
wire [31:0] pcd_out_reg;
wire [31:0] pcx_out_reg;
wire [31:0] pcm_out_reg;
wire [31:0] rs1x_out_reg;
wire [31:0] rs2x_out_reg;
wire [31:0] instx_out_reg;
wire [31:0] instm_out_reg;
wire [31:0] alum_out_reg;
wire [31:0] rs2m_out_reg;
wire [31:0] instw_out_reg;
wire [31:0] wb_pl_out_reg;
wire [31:0] pc_4_piped;
wire [31:0] a_hz_out,b_hz_out;
wire [1:0]  a_hz_sel,b_hz_sel;
wire        pcsel_hz,regwen_hz;

 


	
///////////////////////////////////////////////////////////////////////////////////Components instansiation section///////////////////////////////////////////////////////		
	MUX_2      pc_mux       (.sel(pcsel_hz) , .data2(pc_4) , .data1(alu_out) , .out(pcmux_out))                                ;  //Pc selection mux
	
	reg_mod	  instd			(.data_in(dp_imem_inst)     ,.data_out(instd_out_reg)    ,.clk(dp_clk) , .rst(dp_rst))										;    //imem_regfile
	
	reg_mod	  pcd			(.data_in(pc_next)     ,.data_out(pcd_out_reg)    ,.clk(dp_clk),.rst(dp_rst))                                       ;		//
	
	reg_mod	  pcx			(.data_in(pcd_out_reg)     ,.data_out(pcx_out_reg)    ,.clk(dp_clk),.rst(dp_rst))                                   ;
	
	reg_mod	  pcm			(.data_in(pcx_out_reg)     ,.data_out(pcm_out_reg)    ,.clk(dp_clk),.rst(dp_rst))                                   ;
	
	adder      pc_add_pl    (.data1(32'h00000004) , .data2(pcm_out_reg) , .out(pc_4_piped))                                    ;  //Increments the PC by 4
	
	hazard_control_v2 h1        (.inst_x(instx_out_reg),.inst_m(instm_out_reg),.inst_w(instw_out_reg),.mux_a(a_hz_sel),.mux_b(b_hz_sel),
										  .pcsel_in_x(dp_pcsel) ,.pcsel_in_m(dp_pcsel_m) ,.pcsel_in_w(dp_pcsel_w) ,.pcsel_out(pcsel_hz) ,.regw_in(dp_regwen_hz_in) ,.regw_out(dp_regwen_hz_out) 
										  ,.dmemw_in(dp_dmemw_in) ,.dmemw_out(dp_dmemw_out));
	
	reg_mod	  rs1x			(.data_in(data_a)     ,.data_out(rs1x_out_reg)    ,.clk(dp_clk),.rst(dp_rst))                                    ;
	MUX_3      a_hz			(.data1(rs1x_out_reg),.data2(alum_out_reg),.data3(wb_pl_out_reg),.sel(a_hz_sel),.out(a_hz_out));
	  
	reg_mod	  rs2x			(.data_in(data_b)     ,.data_out(rs2x_out_reg)    ,.clk(dp_clk),.rst(dp_rst))                                    ;
   MUX_3      b_hz			(.data1(rs2x_out_reg),.data2(alum_out_reg),.data3(wb_pl_out_reg),.sel(b_hz_sel),.out(b_hz_out));
	
	reg_mod	  alum			(.data_in(alu_out)     ,.data_out(alum_out_reg)    ,.clk(dp_clk),.rst(dp_rst));
	
	reg_mod	  rs2m			(.data_in(b_hz_out)     ,.data_out(rs2m_out_reg)    ,.clk(dp_clk),.rst(dp_rst))                             ;
	 
	reg_mod	  instm			(.data_in(instx_out_reg)     ,.data_out(instm_out_reg)    ,.clk(dp_clk),.rst(dp_rst));
	
	reg_mod	  instw			(.data_in(instm_out_reg)     ,.data_out(instw_out_reg)    ,.clk(dp_clk),.rst(dp_rst));
	
	reg_mod	  instx			(.data_in(instd_out_reg)     ,.data_out(instx_out_reg)    ,.clk(dp_clk),.rst(dp_rst));
	
	reg_mod	  wb_pl			(.data_in(wb)     ,.data_out(wb_pl_out_reg)    ,.clk(dp_clk),.rst(dp_rst));
	
	
	pc_reg     pc_r         (.pc_in(pcmux_out) , .pc_out(pc_next) , .clk(dp_clk) , .rst(dp_rst))            ;  //Pc register
	
	adder      pc_add       (.data1(32'h00000004) , .data2(pc_next) , .out(pc_4))                           ;  //Increments the PC by 4
	
	reg_file   regf         (.addr_a(instd_out_reg[19:15]) , .addr_b(instd_out_reg[24:20])                    ,  //Reg file
							      .addr_d(instw_out_reg[11:7]) , .data_a(data_a) , .data_b(data_b)                 , 
							      .data_d(wb_pl_out_reg) , .regwen(dp_regwen_in) , .clk(dp_clk))                                ;
	 
	 
	Imme_Gen   i_gen        (.instr(instx_out_reg[31:7]),.sel(dp_immsel),.out(imm_gen_out))                  ;  //Immediate generator
	 
	
	MUX_3      wb_mux       (.data1(dp_dmem_out),.data2(alum_out_reg),.data3(pc_4_piped),.sel(dp_wbsel),.out(wb))      ;  //wb selection mux
	
	ALU        ALU_inst     (.alu_sel(dp_alusel),.operand1(alu_in1),.operand2(alu_in2),.alu_result(alu_out));  //ALU instance
	
	branch_cmp branch_inst  (.dataA(a_hz_out),.dataB(b_hz_out),.brun(dp_brun),.brlt(dp_brlt),.breq(dp_breq))    ;  //Branch comparator
	
	MUX_2      a_pc_mux     (.sel(dp_asel) , .data2(a_hz_out) , .data1(pcx_out_reg) , .out(alu_in1))              ;  //Mux to choose bet. a and PC 
	
	MUX_2      b_imm_mux     (.sel(dp_bsel) , .data2(b_hz_out) , .data1(imm_gen_out) , .out(alu_in2))          ;  //Mux to choose bet. b and imm.
///////////////////////////////////////////////////////////////////////////////////End of section////////////////////////////////////////////////////////////////////////


endmodule
