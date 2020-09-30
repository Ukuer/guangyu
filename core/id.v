`include "defines.v"

module id
(
	input [`PC_SIZE-1:0]		pc,
	input [`INSTR_SIZE-1:0]		instr,

	// regfiles
	output [`XLEN-1:0]			read_data1,
	output [`XLEN-1:0]			read_data2,

	output [`XLEN-1:0]			imm,
	output [`PC_SIZE-1:0]		bxx_imm,
	output [3:0]				alu_funct,
	output [`RFIDX_WIDTH-1:0]	rd_index,
	output [`RFIDX_WIDTH-1:0]	rs1_index,
	output [`RFIDX_WIDTH-1:0]	rs2_index,
	output [`PC_SIZE-1:0]		pc_out,
	output [2:0]				m_mem_mode,

	// for ifecth stage
	output [`XLEN-1:0]			jalr_reg,
	output						jalr_en,

	input [`RFIDX_WIDTH-1:0]	write_index,
	input [`XLEN-1:0]			write_data,
	input						reg_write,

	// control sign 
	input			bxx_flush,
	output			ex_branch,
	output			ex_add2_sel,
	output [1:0]	ex_alu_op,
	output			ex_pc_sel,
	output			m_mem_read,
	output			m_mem_write,
	output			wb_reg_write,
	output			wb_memtoreg,

	input clk,
);

// extend immidate
// IA-type and LD-type
wire[11:0] imm11 = instr[`RANGE_IMM12];
wire [`XLEN-1:0]	imm_ext = 
	{(`XLEN-12){imm11[11]}, imm11[11:0]};

// I-shift-type
wire [4:0] shamt_imm = instr[`RANGE_SHAMT];
wire [`XLEN-1:0]	shift_imm = 
	{(`XLEN-5)'b0, shamt_imm};
wire shift_imm_sel;
assign i_imm = shift_imm_sel ? shift_imm : imm_ext;

// S-type immidate
wire s_imm_sel;
wire [`XLEN-1:0] s_imm = {20{instr[31]}, instr[`RANGE_S_IMM11], instr[`RANGE_S_IMM4]};

assign imm = s_imm_sel ? s_imm : i_imm;

// B-type immidate
assign bxx_imm = {20{instr[`RANGE_B_IMM12]},
		instr[`RANGE_B_IMM11],instr[`RANGE_B_IMM10],
		instr[`RANGE_B_IMM4], 1'b0};




// regfiles
wire [`RFIDX_WIDTH-1:0] rs1, rs2;
assign rs1 = instr[`RANGE_RS1];
assign rs2 = instr[`RANGE_RS2];

// the index of reg to output
assign rd_index = instr[`RANGE_RD];
assign rs1_index = rs1;
assign rs2_index = rs2;

regfile regfile(
		.read_addr1(rs1),
		.read_addr2(rs2),
		.write_addr(write_index),
		.write_data(write_data),
		.read_data1(read_data1),
		.read_data2(read_data2),
		.reg_write(reg_write),
		.clk(clk)
		);

// jalr reg
assign jalr_reg = read_data1;

// the data for ALU-control
assign alu_funct = {instr[30],instr[14:12]};

// mem mode
assign m_mem_mode = instr[`RANGE_S_MODE];

// control
wire [6:0] opcode = instr[`RANGE_OP];

control  id_control
(
		.opcode(opcode),
		.shift_funct4(alu_funct), // same bits
		.bxx_flush(bxx_flush),		

		.if_jalr_en(jalr_en),
		.shift_imm_sel(shift_imm_sel),
		.s_imm_sel(s_imm_sel),

		.ex_branch(ex_branch),
		.ex_add2_sel(ex_add2_sel),
		.ex_alu_op(ex_alu_op),
		.ex_pc_sel(ex_pc_sel),

		.wb_reg_write(wb_reg_write),
		.wb_memtoreg(wb_memtoreg),

		.m_mem_read(m_mem_read),
		.m_mem_write(m_mem_write),
);

endmodule
