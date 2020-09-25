`include "defines.v"

module fetch
(
	input [`PC_SIZE-1:0]	ex_pc,
	output [`PC_SIZE-1:0]	pc_out,
	input					pc_en,
	input					pc_src,

	input					pc_rst_n,
	input					clk,
);

wire [`PC_SIZE-1:0] pc_p4 = pc_out + 4;

wire [`PC_SIZE-1:0]  pc_next = pc_src ? ex_pc : pc_p4;

dfflr pc #(`PC_SIZE)(pc_en, pc_next, pc_out, clk, pc_rst_n);

endmodule
