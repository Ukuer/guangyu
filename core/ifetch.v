`include "defines.v"
module ifecth
(
	input [`PC_SIZE-1:0]		ex_pc,
	output [`PC_SIZE-1:0]		pc_out,
	output [`INSTR_SIZE-1:0]	instr,

	input					ld_stall,
	input					pc_sel_src,

	output					take,

	input					clk
	input					pc_rst_n,	
);

wire [`PC_SIZE-1:0]	pc_next;
wire	if_en;


pc pc(	.pc_next(pc_next),
		.pc_out(pc_out),
		.pc_rst_n(pc_rst_n),
		.if_en(if_en),
		.clk(clk)
		);

icache icache(	.addr(pc_out),
				.en(if_en),
				.instr(instr)
				);

predecode predecode(	.instr(instr),
						.pc(pc_out),
						.ld_stall(ld_stall),
						.ex_pc(ex_pc),
						.pc_sel(pc_sel_src),
						.take(take),
						.pc_next(pc_next);
						);

endmodule


