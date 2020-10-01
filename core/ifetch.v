`include "defines.v"
module ifecth
(
	output [`PC_SIZE-1:0]		pc_out,
	output [`INSTR_SIZE-1:0]	instr_out,

	input						id_jalr,
	input [`PC_SIZE-1:0]		id_reg_value,

	input						predict_fail,
	input [`PC_SIZE-1:0]		bxx_fail_imm,
	input [`PC_SIZE-1:0]		bxx_fail_pc,

	output						take,

	input						clk
	input						pc_rst_n,	
);

wire [`PC_SIZE-1:0]	pc_next;
wire [`PC_SIZE-1:0]	pc;
wire [`INSTR_SIZE-1:0]	instr,
wire	if_en;
wire	instr_nop_sel;

assign pc_out = pc;
assign instr_out = instr_nop_sel ? `INSTR_NOP : instr;


pc pc(	.pc_next(pc_next),
		.pc_out(pc),
		.pc_rst_n(pc_rst_n),
		.if_en(if_en),
		.clk(clk)
		);

icache icache(	.addr(pc),
				.en(if_en),
				.instr(instr)
				);

predecode predecode(	.instr(instr),
						.pc(pc),
						.id_jalr(id_jalr),
						.id_reg_value(id_reg_value),
						.instr_nop_sel(instr_nop_sel),
						.predict_fail(predict_fail),
						.take(take),
						.pc_next(pc_next);
						);

endmodule
