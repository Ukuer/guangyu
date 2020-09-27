`include "defines.v"

module fetch
(
	input [`PC_SIZE-1:0]	ex_pc,
	output [`PC_SIZE-1:0]	pc_out,
	input					pc_en,
	input					pc_sel_src,

	input					pc_rst_n,
	output					if_en,			// enable sign for ifetch
	input					clk,
);

wire [`PC_SIZE-1:0] pc_p4 = pc_out + 4;

wire [`PC_SIZE-1:0]  pc_next = pc_sel_src ? ex_pc : pc_p4;

assign if_en = pc_rst_n;

dfflr pc #(`PC_SIZE)(pc_en, pc_next, pc_out, clk, pc_rst_n);

endmodule
