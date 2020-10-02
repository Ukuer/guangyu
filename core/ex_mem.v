`include "defines.v"

module ex_mem
(
	
	input				m_mem_read,
	output				m_mem_read_out,
	input				m_mem_write,
	output				m_mem_write_out,
	input				wb_reg_write,
	output				wb_reg_write_out,
	input				wb_memtoreg,
	output				wb_memtoreg_out,

	input [`XLEN-1:0]	ex_result,
	output [`XLEN-1:0]	ex_result_out,

	input [`XLEN-1:0]	rs2_data,
	output [`XLEN-1:0]	rs2_data_out,
	
	input [2:0]					m_mem_mode,
	output [2:0]				m_mem_mode_out,
	input [`RFIDX_WIDTH-1:0]	rd_index,
	output [`RFIDX_WIDTH-1:0]	rd_index_out,

	input			clk
);

dff #(1) m_mem_read_reg(m_mem_read, m_mem_read_out, clk);

dff #(1) m_mem_write_reg(m_mem_write, m_mem_write_out, clk);

dff #(1) wb_reg_write_reg(wb_reg_write, wb_reg_write_out,clk);

dff #(1) wb_memtoreg_reg (wb_memtoreg, wb_memtoreg_out,clk);


dff #(`XLEN)ex_result_reg (ex_result, ex_result_out, clk);

dff #(`XLEN) rs2_data_reg(rs2_data, rs2_data_out, clk);

dff #(3) m_mem_mode_reg(m_mem_mode, m_mem_mode_out, clk);

dff #(`RFIDX_WIDTH) rd_index_reg (rd_index, rd_index_out, clk);


endmodule 
