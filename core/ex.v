`include "defines.v"

module ex
(
	input [`XLEN-1:0]		rs1_data,
	input [`XLEN-1:0]		rs2_data,

	input [`XLEN-1:0]		imm,
	input [`XLEN-1:0]		lui_imm,
	input [`PC_SIZE-1:0]	pc,

	input [3:0]				alu_funct,

	input					ex_branch,
	input					ex_add2_sel,
	input					ex_pc_sel,
	input					ex_lui_sel,
	input [1:0]				ex_alu_op,
	
	output [`XLEN-1:0]		result,
	output [`XLEN-1:]		rs2_data_out,

	output					bxx_flush,
	output					predict_fail,
);


// alu
wire [`XLEN-1:0] alu_add1 = ex_pc_sel ? pc : rs1_data;

wire [`XLEN-1:0] alu_add2 = (ex_alu_op == `ADD2_RS2)? rs2_data :
(ex_alu_op == `ADD2_IMM) ? imm :
(ex_alu_op == `ADD2_0) ? `XLEN'b0:
(ex_alu_op == `ADD2_LUI) ? lui_imm;









