`include "defines.v"

module mem
(
	input [`XLEN-1:0]	ex_result,
	input [`XLEN-1:0]	rs2_data,

	input				m_mem_read,
	input				m_mem_write,
	
	input [2:0]			m_mem_mode,

	output [`XLEN-1:0]	m_data,
	output [`XLEN-1:0]	ex_result_out

);



assign ex_result_out = ex_result;

dcache dcache(
				.addr(ex_result),
				.data_in(rs2_data),
				.mode(m_mem_mode),
				.write_en(m_mem_write),
				.read_en(m_mem_read),
				.data_out(m_data)
				);


endmodule


