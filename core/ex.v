`include "defines.v"

module ex
(
	input [`XLEN-1:0]		rs1_data,
	input [`XLEN-1:0]		rs2_data,

	input [`XLEN-1:0]		imm,
	input [`XLEN-1:0]		lui_imm,
	input [`XLEN-1:0]		bxx_imm,
	input [`PC_SIZE-1:0]	pc,

	input [3:0]				alu_funct,
	input [2:0]				bxx_funct,
	input					take,

	input					ex_branch,
	input					ex_add2_sel,
	input					ex_pc_sel,
	input					ex_lui_sel,
	input [1:0]				ex_alu_op,
	
	output [`XLEN-1:0]		result,
	output [`XLEN-1:]		rs2_data_out,

	output					bxx_flush,
	output					predict_fail,
	output [`XLEN-1:0]		fail_addr,
);

// alu control
wire [3:0]	alu_sel;
alu_control alu_control (	.ex_alu_op(ex_alu_op),
							.alu_funct(alu_funct),

							.alu_sel(alu_sel)
						);

// alu
wire [`XLEN-1:0] alu_add1 = ex_pc_sel ? pc : rs1_data;

wire [`XLEN-1:0] alu_add2 = (ex_alu_op == `ADD2_RS2)? rs2_data :
	(ex_alu_op == `ADD2_IMM) ? imm :
	(ex_alu_op == `ADD2_0) ? `XLEN'b0:
	(ex_alu_op == `ADD2_LUI) ? lui_imm : 
	`XLEN'b0;		// the default is zero word

assign result = ex_lui_sel ? lui_imm : alu_sum; 

wire [`XLEN-1:0]	alu_sum;
wire				alu_zero;
wire				alu_sign;
wire				alu_carry;


alu alu(	.add1(alu_add1),
			.add2(alu_add2),
			.alu_sel(alu_sel),
			.sum(alu_sum),
			.zero(alu_zero),
			.sign(alu_sign),
			.carry(alu_carry)
		);


// bxx prediction test
ex_bpt  ex_bpt 
(
	.ex_branch(ex_branch),
	.bxx_funct(bxx_funct),

	.alu_zero(alu_zero),
	.alu_sign(alu_sign),
	.alu_carry(alu_carry),
	.take(take),

	.bxx_imm(bxx_imm),

	.bxx_flush(bxx_flush),
	.predict_fail(predict_fail),
	.fail_addr(fail_addr),
);
		

endmodule
