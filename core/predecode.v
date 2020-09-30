`include "defines.v"

module predecode
(
	input [`INSTR_SIZE-1:0]		instr,
	input [`PC_SIZE-1:0]		pc,
	

	// if id_jalr is on
	// nop the instruction and
	// add id_reg_value to produce new address
	input						id_jalr,
	input [`PC_SIZE-1:0]		id_reg_value,

	output						instr_nop_sel,	// if make the output of ifecth_module be nop

	output						take,	// indicate if bxx prediction is taken

	input						predict_fail,	// if the bxx prediction is failed
	input [`PC_SIZE-1:0]		bxx_fail_imm,
	input [`PC_SIZE-1:0]		bxx_fail_pc,
	
	output [`PC_SIZE-1:0]		pc_next,	// the pc of next clk
);

wire [6:0] opcode = instr[6:0]

wire jal = (opcode == `OPCODE_JAL);
wire bxx = (opcode == `OPCODE_B_TYPE);

assign instr_nop_sel = id_jalr;	

// the immidate offset of pc in jal
wire [`PC_SIZE-1:0] jal_imm_addr = 
		{ 12{instr[`RANGE_J_IMM20]},instr[`RANGE_J_IMM19],
		instr[`RANGE_J_IMM11], instr[`RANGE_B_IMM10], 1'b0};


// the immidate offset of pc in bxx
wire [`PC_SIZE-1:0]	bxx_imm_addr = 
		{ 20{instr[`RANGE_B_IMM12], instr[RANGE_B_IMM11], 
		instr[`RANGE_B_IMM10], instr[`RANGE_B_IMM4], 1'b0};


// if jump back, the prediction is taken,
// otherwise not taken
assign take = instr[`RANGE_B_IMM12];


wire [`PC_SIZE-1:0] add1, add2;

assign add1 = predict_fail ? bxx_fail_pc : pc;

assign add2 =	jal  ? jal_imm_addri+4:	
				(bxx & take) ?	bxx_imm_addr+4:
				id_jalr ? id_reg_value : 
				predict_fail ? bxx_fail_imm :
							`PC_SIZE'd4;

assign sum = pc + add2;

assign pc_next = sum;

endmodule
