`include "defines.v"

module if_id
(
	input [`PC_SIZE-1:0]		pc_in,
	output [`PC_SIZE-1:0]		pc_out,
	input [`INSTR_SIZE-1:0]		instr_in,
	output [`INSTR_SIZE-1:0]	instr_out,
	
	input clk,
);

dff pc_register #(`PC_SIZE) (pc_in, pc_out, clk);
dff instr_register #(`INSTR_SIZE)(instr_in, instr_out, clk);


endmodule 


