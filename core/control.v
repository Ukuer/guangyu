`include "defines.v"

module control
(
	input [6:0]		opcode,
	input [3:0]		shift_funct4,	// 识别是否是移位指令
	
	input			bxx_flush,		

	output reg	if_jalr_en,

	output reg		shift_imm_sel,
	output reg			s_imm_sel,

	output reg			ex_branch,
	output reg[1:0]	ex_add2_sel,
	output reg[1:0]	ex_alu_op,
	output reg			ex_pc_sel,
	output reg			ex_lui_sel,

	output reg			wb_reg_write,
	output reg			wb_memtoreg,

	output reg			m_mem_read,
	output reg			m_mem_write

);

//reg [6:0] opcode_r;

always @(*)
begin
if (bxx_flush == 1'b1) begin
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_RS2;
		ex_alu_op <= `ALU_OP_R;
		ex_pc_sel <= 1'b0;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

else begin 

	case(opcode)
	
	`OPCODE_R_TYPE:	begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_RS2;
		ex_alu_op <= `ALU_OP_R;
		ex_pc_sel <= 1'b0;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	`OPCODE_IA_TYPE: begin
		if (shift_funct4 == 4'b0001 ||
			shift_funct4 == 4'b0101 ||
			shift_funct4 == 4'b1101)
			
			shift_imm_sel <= 1'b1;
		else 
			shift_imm_sel <= 1'b0;

		s_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_pc_sel <= 1'b0;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end
		
	`OPCODE_ID_TYPE: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_alu_op <= `ALU_OP_I;
		ex_pc_sel <= 1'b0;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b1;
		m_mem_read <= 1'b1;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end
		
	`OPCODE_B_TYPE: begin
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b1;
		ex_add2_sel <= `ADD2_RS2;
		ex_alu_op <= `ALU_OP_SUB;
		ex_pc_sel <= 1'b0;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	`OPCODE_JAL: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b1;
		ex_add2_sel <= `ADD2_0;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b1;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	`OPCODE_JALR: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b1;
		ex_add2_sel <= `ADD2_0;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b1;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b1;
		end

	`OPCODE_S_TYPE: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b1;
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b0;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b1;
		if_jalr_en <= 1'b0;
		end
	
	`OPCODE_LUI: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_0;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b0;
		ex_lui_sel <= 1'b1;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	`OPCODE_AUIPC: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_LUI;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b1;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	`OPCODE_NOP: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b0;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	default: begin
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b0;
		ex_lui_sel <= 1'b0;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	endcase
end
end

endmodule
