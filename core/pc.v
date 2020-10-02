`include "defines.v"

module pc
(
	input [`PC_SIZE-1:0]	pc_next,
	output [`PC_SIZE-1:0]	pc_out,

	input					pc_rst_n,
	output					if_en,			// enable sign for ifetch
	input					clk
);

assign if_en = pc_rst_n;

dfflr # (32) pcr (pc_next, pc_out, clk, pc_rst_n);

endmodule
