`include "defines.v"

module cpu(
			input clk,
			input pc_rst_n,
);

////////////////////////////////////////////////
wire [`PC_SIZE-1:0]		if_pc;
wire [`INSTR_SIZE-1:0]	if_instr;
wire					id_jalr;
wire [`PC_SIZE-1:0]		id_reg_value;
wire					ex_predict_fail;
wire [`PC_SIZE-1:0]		ex_bxx_fail_imm;
wire [`PC_SIZE-1:0]		ex_bxx_fail_pc;
wire					if_take;


ifecth ifecth (
	.pc_out(if_pc),
	.instr_out(if_instr),

	.id_jalr(id_jalr),
	.id_reg_value(id_reg_value),

	.predict_fail(ex_predict_fail),
	.bxx_fail_imm(ex_bxx_fail_imm),
	.bxx_fail_pc(ex_bxx_fail_pc),

	.take(if_take),

	.clk(clk),
	.pc_rst_n(pc_rst_n),	
);

/////////////////////////////////////////////////
wire [`PC_SIZE-1:0]			id_pc;
wire [`INSTR_SIZE-1:0]		id_instr;
wire						id_take;


if_id if_id (
	.pc(if_pc),
	.pc_out(id_pc),

	.instr(if_instr),
	.instr_out(id_instr),
	
	.take(if_take),
	.take_out(id_take),

	.clk(clk),
);

///////////////////////////////////////////////
wire [`XLEN-1:0]		id_data1, id_data2;
wire [`XLEN-1:0]		id_imm;
wire [`PC_SIZE-1:0]		id_bxx_imm;
wire [`XLEN-1:0]		id_lui_imm;
wire [2:0]				id_bxx_funct;
wire [3:0]				id_alu_funct;
wire [`RFIDX_WIDTH-1:0]	id_rd_index;
wire [`RFIDX_WIDTH-1:0]	id_rs1_index;
wire [`RFIDX_WIDTH-1:0]	id_rs2_index;


wire [2:0]				id_m_mem_mode;

wire [`RFIDX_WIDTH-1:0]	wb_write_index;
wire [`XLEN-1:0]		wb_write_data;
wire 					wb_reg_write;

wire    id_ex_bxx_flush;
wire 	id_ex_branch;
wire	id_ex_add2_sel;
wire [1:0]	id_ex_alu_op;
wire	id_ex_pc_sel;
wire	id_ex_lui_sel;
wire 	id_m_mem_read;
wire 	id_m_mem_write;
wire	id_wb_reg_write;
wire	id_wb_memtoreg;



id  id (

	.read_data1(id_data1),
	.read_data2(id_data2),

	.imm(id_imm),
	.bxx_imm(id_bxx_imm),
	.lui_imm(id_lui_imm),

	.bxx_funct(id_bxx_funct),
	.alu_funct(id_alu_funct),
	
	.rd_index(id_rd_index),
	.rs1_index(id_rs1_index),
	.rs2_index(id_rs2_index),
	
	.m_mem_mode(id_m_mem_mode),

	// for ifecth stage
	.jalr_reg(id_reg_value),
	.jalr_en(id_jalr),

	.write_index(wb_write_index),
	.write_data(wb_write_data),
	.reg_write(wb_reg_write),

	// control sign 
	.bxx_flush(id_ex_bxx_flush),
	.ex_branch(id_ex_branch),
	.ex_add2_sel(id_ex_add2_sel),
	.ex_alu_op(id_ex_alu_op),
	.ex_pc_sel(id_ex_pc_sel),
	.ex_lui_sel(id_ex_lui_sel),
	.m_mem_read(id_m_mem_read),
	.m_mem_write(id_m_mem_write),
	.wb_reg_write(id_wb_reg_write),
	.wb_memtoreg(id_wb_memtoreg),

	.clk(clk),
);


//////////////////////////////////////////////////

wire [`XLEN-1:0]		ex_data1, ex_data2;
wire [`XLEN-1:0]		ex_imm;
wire [`PC_SIZE-1:0]		ex_bxx_imm;
wire [`XLEN-1:0]		ex_lui_imm;
wire [2:0]				ex_bxx_funct;
wire [3:0]				ex_alu_funct;
wire [`RFIDX_WIDTH-1:0]	ex_rd_index;
wire [`RFIDX_WIDTH-1:0]	ex_rs1_index;
wire [`RFIDX_WIDTH-1:0]	ex_rs2_index;

wire [`PC_SIZE-1:0]		ex_pc;

assign	ex_pc = ex_bxx_fail_pc;

wire [2:0]			ex_m_mem_mode;


wire    ex_bxx_flush;
wire 	ex_branch;
wire	ex_add2_sel;
wire [1:0]	ex_alu_op;
wire	ex_pc_sel;
wire 	ex_m_mem_read;
wire	ex_lui_sel;
wire 	ex_m_mem_write;
wire	ex_wb_reg_write;
wire	ex_wb_memtoreg;
wire	ex_take;


id_ex id_ex (
	.read_data1(id_data1),
	.read_data1_out(ex_data1),
	.read_data2(id_data2),
	.read_data2_out(ex_data2),
	
	.imm(id_imm),
	.imm_out(ex_imm),
	.lui_imm(id_lui_imm),
	.lui_imm_out(ex_lui_imm),
	.bxx_imm(id_bxx_imm),
	.bxx_imm_out(ex_bxx_imm),

	.alu_funct(id_alu_funct),
	.alu_funct_out(ex_alu_funct),
	.bxx_funct(id_bxx_funct),
	.bxx_funct_out(ex_bxx_funct),

	.rd_index(id_rd_index),
	.rd_index_out(ex_rd_index),
	.rs1_index(id_rs1_index),
	.rs1_index_out(ex_rs1_index),
	.rs2_index(id_rs2_index),
	.rs2_index_out(ex_rs2_index),
	.pc(id_pc),
	.pc_out(ex_pc),

	.m_mem_mode(id_m_mem_mode),
	.m_mem_mode_out(ex_m_mem_mode),

		// control sign
	.ex_branch(id_ex_branch),
	.ex_branch_out(ex_branch),
	.ex_add2_sel(id_ex_add2_sel),
	.ex_add2_sel_out(ex_add2_sel),
	.ex_alu_op(id_ex_alu_op),
	.ex_alu_op_out(ex_alu_op),
	.ex_pc_sel(id_ex_pc_sel),
	.ex_pc_sel_out(ex_pc_sel),
	.ex_lui_sel(id_ex_lui_sel),
	.ex_lui_sel_out(ex_lui_sel),
	.m_mem_read(id_m_mem_read),
	.m_mem_read_out(ex_m_mem_read),
	.m_mem_write(id_m_mem_write),
	.m_mem_write_out(ex_m_mem_read),
	.wb_reg_write(id_wb_reg_write),
	.wb_reg_write_out(ex_wb_reg_write),
	.wb_memtoreg(id_wb_memtoreg),
	.wb_memtoreg_out(ex_wb_memtoreg),

	.take(id_take),
	.take_out(ex_take),
	.clk(clk),
);


///////////////////////////////////////////////////

wire [`XLEN-1:0]	ex_result;
wire [`XLEN-1:0]	ex_rs2_data_out;

ex ex (
	.rs1_data(ex_data1),
	.rs2_data(ex_data2),

	.imm(ex_imm),
	.lui_imm(ex_lui_imm),
	.bxx_imm(ex_bxx_imm),
	.pc(ex_pc),

	.alu_funct(ex_alu_funct),
	.bxx_funct(ex_bxx_funct),
	.take(ex_take),

	.ex_branch(ex_branch),
	.ex_add2_sel(ex_add2_sel),
	.ex_pc_sel(ex_pc_sel),
	.ex_lui_sel(ex_lui_sel),
	.ex_alu_op(ex_alu_op),
	
	.result(ex_result),
	.rs2_data_out(ex_rs2_data_out),

	.bxx_flush(id_ex_bxx_flush),
	.predict_fail(ex_predict_fail),
	.fail_addr(ex_bxx_fail_imm),
);

/////////////////////////////////////////////
wire		m_mem_read, m_mem_write;
wire		mem_wb_memtoreg, mem_wb_reg_write;
wire [`XLEN-1:0]	mem_result;
wire [`XLEN-1:0]	mem_rs2_data_out;
wire [2:0]			m_mem_mode;
wire [`RFIDX_WIDTH-1:0]	mem_rd_index;

ex_mem	ex_mem (
	.m_mem_read(ex_m_mem_read),
	.m_mem_read_out(m_mem_read),
	.m_mem_write(ex_m_mem_write),
	.m_mem_write_out(m_mem_write),
	.wb_reg_write(ex_wb_reg_write),
	.wb_reg_write_out(mem_wb_reg_write),
	.wb_memtoreg(ex_wb_memtoreg),
	.wb_memtoreg_out(mem_wb_memtoreg),

	.ex_result(ex_result),
	.ex_result_out(mem_result),

	.rs2_data(ex_rs2_data_out),
	.rs2_data_out(mem_rs2_data_out),
	
	.m_mem_mode(ex_m_mem_mode),
	.m_mem_mode_out(m_mem_mode),
	.rd_index(ex_rd_index),
	.rd_index_out(mem_rd_index),

	.clk(clk),
);

////////////////////////////////////////////////

wire [`XLEN-1:0]	mem_data,
wire [`XLEN-1:0]	mem_result_out,

mem mem (
	.ex_result(mem_result),
	.rs2_data(mem_rs2_data_out),

	.m_mem_read(m_mem_read),
	.m_mem_write(m_mem_write),
	
	.m_mem_mode(m_mem_mode),

	.m_data(mem_data),
	.ex_result_out(mem_result_out),

);

/////////////////////////////////////////////////

wire [`XLEN-1:0]	wb_data,
wire [`XLEN-1:0]	wb_result_out,
wire [`RFIDX_WIDTH-1:0]	wb_rd_index;
wire				wb_memtoreg, wb_reg_write;
mem_wb mem_wb (
	.m_data(mem_data),
	.m_data_out(wb_data),

	.ex_result(m_mem_read_out),
	.ex_result_out(wb_result_out),
	
	.wb_reg_write(mem_wb_reg_write),
	.wb_reg_write_out(wb_reg_write),
	.wb_memtoreg(mem_wb_memtoreg),
	.wb_memtoreg_out(wb_memtoreg),

	.rd_index(mem_rd_index),
	.rd_index_out(wb_write_index),
);

///////////////////////////////////////////
module wb
(
	.m_data(wb_data),
	.ex_result(wb_result_out),

	.wb_memtoreg(wb_memtoreg),

	.write_reg_data(wb_write_data),
);

endmodule
