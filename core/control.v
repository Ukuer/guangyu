`include "defines.v"

module control
(
	input [6:0]		opcode,

	output			wb_reg_write,
	output			wb_memtoreg,
	output			m_branch,
	output			m_mem_read,
	output			m_mem_write,
	output			ex_aluop,
	output			ex_alu_selimm,
	output [1:0]	alu_op

);



