`include "defines.v"

module id
(
	input [`PC_SIZE-1:0]		pc,
	input [`INSTR_SIZE-1:0]		instr,

	output [`XLEN-1:0]			read_data1,
	output [`XLEN-1:0]			read_data2,
	output [`XLEN-1:0]			imm_ext,
	output [3:0]				alu_funct,
	output [`RFIDX_WIDTH-1:0]	rd_index,
	output [`PC_SIZE-1:0]		pc_out,

	input [`RFIDX_WIDTH-1:0]	write_index,
	input [`XLEN-1:0]			write_data,
	input						reg_write,
	// control sign 

	input clk,
);

// extend immidate
wire[11:0] imm11 = instr[`RANGE_IMM12];
assign imm_ext = {(`XLEN-12){imm11[11]}, imm11};

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

// the data for ALU-control
assign alu_funct = {instr[30],instr[14:12]};

// control
wire [6:0] opcode = instr[`RANGE_OP];



endmodule
