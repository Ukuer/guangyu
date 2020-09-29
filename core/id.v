`include "defines.v"

module id
(
	input [`PC_SIZE-1:0]		pc,
	input [`INSTR_SIZE-1:0]		instr,

	output [`XLEN-1:0]			read_data1,
	output [`XLEN-1:0]			read_data2,
	output [`XLEN-1:0]			imm,
	output [3:0]				alu_funct,
	output [`RFIDX_WIDTH-1:0]	rd_index,
	output [`RFIDX_WIDTH-1:0]	rs1_index,
	output [`RFIDX_WIDTH-1:0]	rs2_index,
	output [`PC_SIZE-1:0]		pc_out,

	output [`XLEN-1:0]			jalr_reg,

	output [2:0]				m_mem_mode,

	input [`RFIDX_WIDTH-1:0]	write_index,
	input [`XLEN-1:0]			write_data,
	input						reg_write,
	// control sign 

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

assign i_imm = shift_sel ? shift_imm : imm_ext;

// S-type immidate
wire s_imm_sel;
wire [`XLEN-1:0] s_imm = {20{instr[31]}, instr[`RANGE_S_IMM11], instr[`RANGE_S_IMM4]};

assign imm = s_imm_sel ? s_imm : i_imm;


// regfiles
wire [`RFIDX_WIDTH-1:0] rs1, rs2;
assign rs1 = instr[`RANGE_RS1];
assign rs2 = instr[`RANGE_RS2];

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

// control
wire [6:0] opcode = instr[`RANGE_OP];


// rd
assign rd_index = instr[`RANGE_RD];


// mem mode
assign m_mem_mode = instr[`RANGE_S_MODE];



endmodule
