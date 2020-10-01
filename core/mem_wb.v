`include "defines.v"

module mem_wb
(
	input [`XLEN-1:0]		m_data,
	output [`XLEN-1:0]		m_data_out,

	input [`XLEN-1:0]		ex_result,
	output [`XLEN-1:0]		ex_result_out,
	
	input					wb_reg_write,
	output					wb_reg_write_out,
	input					wb_memtoreg,
	output					wb_memtoreg_out,

	input [`RFIDX_WIDTH-1:0]	rd_index,
	output [`RFIDX_WIDTH-1:0]	rd_index_out,
);


dff wb_reg_write_reg#(1)(wb_reg_write, wb_reg_write_out,clk);

dff wb_memtoreg_reg#(1)(wb_memtoreg, wb_memtoreg_out,clk);

dff rd_index_reg#(`RFIDX_WIDTH)(rd_index, rd_index_out, clk);


dff ex_result_reg#(`XLEN)(ex_result, ex_result_out, clk);

dff m_data_reg#(`XLEN)(m_data, m_data_out, clk);
endmodule
