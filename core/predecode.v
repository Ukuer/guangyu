`include "defines.v"

module predecode
(
	input [`INSTR_SIZE-1:0]		instr,
	input [`PC_SIZE-1:0]		pc,
	
	input						ld_stall,
	input [`PC_SIZE-1:0]		ex_pc,
	input						pc_sel,

	input						take,
	
	output [`PC_SIZE-1:0]		pc_next,
);

wire opcode = instr[6:0]

wire jal = (opcode == `OPCODE_JAL);
wire bxx = (opcode == `OPCODE_B_TYPE);


wire [`PC_SIZE-1:0] jal_addr = 
		{ 12{instr[`RANGE_J_IMM20]},instr[`RANGE_J_IMM19],instr[`RANGE_J_IMM11], instr[`RANGE_B_IMM10], 1'b0};

wire [`PC_SIZE-1:0]	bxx_addr = 
		{ 20{instr[`RANGE_B_IMM12], instr[RANGE_B_IMM11], instr[`RANGE_B_IMM10], instr[`RANGE_B_IMM4], 1'b0};

assign take = instr[`RANGE_B_IMM12];

assign add2 =	ld_stall ? `PC_SIZE'b0 : 
				jal  ? jal_addr:	
				(bxx & take) ?	bxx_addr:`PC_SIZE'd4;

assign sum = pc + add2;

assign pc_next = pc_sel ? ex_pc : sum;

endmodule
