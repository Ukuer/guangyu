`include "defines.v"

module id_ex
(
	input [`XLEN-1:0]			read_data1,
	output [`XLEN-1:0]			read_data1_out,
	input [`XLEN-1:0]			read_data2,
	output [`XLEN-1:0]			read_data2_out,
	
	input [`XLEN-1:0]			imm,
	output [`XLEN-1:0]			imm_out,
	input [`XLEN-1:0]			lui_imm,
	output [`XLEN-1:0]			lui_imm_out,
	input [`PC_SIZE-1:0]		bxx_imm,
	output [`PC_SIZE-1:0]		bxx_imm_out,

	input [3:0]					alu_funct,
	output [3:0]				alu_funct_out,
	input [2:0]					bxx_funct,
	output [2:0]				bxx_funct_out,

	input [`RFIDX_WIDTH-1:0]	rd_index,
	output [`RFIDX_WIDTH-1:0]	rd_index_out,
	input [`RFIDX_WIDTH-1:0]	rs1_index,
	output [`RFIDX_WIDTH-1:0]	rs1_index_out,
	input [`RFIDX_WIDTH-1:0]	rs2_index,
	output [`RFIDX_WIDTH-1:0]	rs2_index_out,
	input [`PC_SIZE-1:0]		pc,
	output [`PC_SIZE-1:0]		pc_out,
	input [2:0]					m_mem_mode,
	output [2:0]				m_mem_mode_out,

	// control sign 
	input			ex_branch,
	output			ex_branch_out,
	input	[1:0]		ex_add2_sel,
	output[1:0]		ex_add2_sel_out,
	input [1:0]		ex_alu_op,
	output [1:0]	ex_alu_op_out,
	input			ex_pc_sel,
	output			ex_pc_sel_out,
	input			ex_lui_sel,
	output			ex_lui_sel_out,
	input			m_mem_read,
	output			m_mem_read_out,
	input			m_mem_write,
	output			m_mem_write_out,
	input			wb_reg_write,
	output			wb_reg_write_out,
	input			wb_memtoreg,
	output			wb_memtoreg_out,

	input			take,
	output			take_out,

	input clk
);

dff #(`XLEN) read_data1_reg(read_data1, read_data1_out, clk);

dff #(`XLEN) read_data2_reg(read_data2, read_data2_out, clk);


//////////////////////////////////////
dff #(`XLEN) imm_reg(imm, imm_out, clk);

dff #(`XLEN) lui_imm_reg (lui_imm, lui_imm_out, clk);

dff #(`XLEN) bxx_imm_reg (bxx_imm, bxx_imm_out, clk);

dff #(4) alu_funct_reg(alu_funct, alu_funct_out, clk);


dff #(3) bxx_funct_reg(bxx_funct, bxx_funct_out, clk);

/////////////////////////////////////
dff #(`RFIDX_WIDTH) rd_index_reg(rd_index, rd_index_out, clk);

dff #(`RFIDX_WIDTH) rs1_index_reg(rs1_index, rs1_index_out, clk);

dff #(`RFIDX_WIDTH) rs2_index_reg(rs2_index, rs2_index_out, clk);

dff #(`PC_SIZE) pc_reg(pc, pc_out, clk);

dff #(3) m_mem_mode_reg(m_mem_mode, m_mem_mode_out, clk);

/////////////////////////////////////
dff #(1) ex_branch_reg(ex_branch, ex_branch_out, clk);

dff #(2) ex_add2_sel_reg(ex_add2_sel, ex_add2_sel_out,clk);

dff #(2) ex_alu_op_reg(ex_alu_op, ex_alu_op_out,clk);

dff #(1) ex_pc_sel_reg(ex_pc_sel, ex_pc_sel_out,clk);

dff #(1) ex_lui_sel_reg(ex_lui_sel, ex_lui_sel_out,clk);

dff #(1) m_mem_read_reg(m_mem_read, m_mem_read_out, clk);

dff #(1) m_mem_write_reg(m_mem_write, m_mem_write_out, clk);

dff #(1) wb_reg_write_reg(wb_reg_write, wb_reg_write_out,clk);

dff #(1) wb_memtoreg_reg(wb_memtoreg, wb_memtoreg_out,clk);


dff #(1) take_reg(take, take_out,clk);

endmodule
