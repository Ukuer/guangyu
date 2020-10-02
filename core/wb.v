`include "defines.v"

module wb
(
	input [`XLEN-1:0]		m_data,
	input [`XLEN-1:0]		ex_result,

	input					wb_memtoreg,

	output [`XLEN-1:0]		write_reg_data
);

assign write_reg_data = wb_memtoreg ? m_data : ex_result;

endmodule
