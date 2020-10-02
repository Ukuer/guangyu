`include "defines.v"

module if_id
(
	input [`PC_SIZE-1:0]		pc,
	output [`PC_SIZE-1:0]		pc_out,

	input [`INSTR_SIZE-1:0]		instr,
	output [`INSTR_SIZE-1:0]	instr_out,
	
	input						take,
	output						take_out,

	input clk
);

dff #(`PC_SIZE) pc_register (pc, pc_out, clk);

dff #(`INSTR_SIZE) instr_register(instr, instr_out, clk);

dff #(1) take_register (take, take_out, clk);


endmodule 


