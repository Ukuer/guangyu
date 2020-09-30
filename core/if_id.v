`include "defines.v"

module if_id
(
	input [`PC_SIZE-1:0]		pc,
	output [`PC_SIZE-1:0]		pc_out,

	input [`INSTR_SIZE-1:0]		instr,
	output [`INSTR_SIZE-1:0]	instr_out,
	
	input						take,
	output						take_out,

	input clk,
);

dff pc_register #(`PC_SIZE) (pc, pc_out, clk);

dff instr_register #(`INSTR_SIZE)(instr, instr_out, clk);

dff take_register #(1)(take, take_out, clk);


endmodule 


