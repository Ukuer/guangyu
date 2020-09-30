`include "defines.v"

module control
(
	input [6:0]		opcode,
	input [3:0]		shift_funct4,	// 识别是否是移位指令
	
	input			bxx_flush,		

	output			if_jalr_en,

	output			shift_imm_sel,
	output			s_imm_sel,

	output			ex_branch,
	output			ex_add2_sel,
	output [1:0]	ex_alu_op,
	output			ex_pc_sel,

	output			wb_reg_write,
	output			wb_memtoreg,

	output			m_mem_read,
	output			m_mem_write,

);

reg [6:0] opcode;

always @(*)
begin
if (bxx_flush == 1'b1) begin
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0,
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_RS2;
		ex_alu_op <= `ALU_OP_R;
		ex_pc_sel <= 1'b0;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

else begin 

	case(opcode):begin
	
	OPCODE_R_TYPE:	begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0,
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_RS2;
		ex_alu_op <= `ALU_OP_R;
		ex_pc_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	OPCODE_IA_TYPE: begin
		if (shift_funct4 == 4'b0001 ||
			shift_funct4 == 4'b0101 ||
			shift_funct4 == 4'b1101)
			
			shift_imm_sel <= 1'b1;
		else 
			shift_imm_sel <= 1'b0;

		s_imm_sel <= 1'b0,
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_pc_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end
		
	OPCODE_ID_TYPE: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0,
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_alu_op <= `ALU_OP_I;
		ex_pc_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b1;
		m_mem_read <= 1'b1;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end
		
	OPCODE_B_TYPE: begin
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0,
		ex_branch <= 1'b1;
		ex_add2_sel <= `ADD2_RS2;
		ex_alu_op <= `ALU_OP_SUB;
		ex_pc_sel <= 1'b0;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	OPCODE_JAL: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0,
		ex_branch <= 1'b1;
		ex_add2_sel <= `ADD2_0;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b1;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	OPCODE_JALR: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0,
		ex_branch <= 1'b1;
		ex_add2_sel <= `ADD2_0;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b1;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b1;
		end

	OPCODE_S_TYPE: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b1,
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b0;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b1;
		if_jalr_en <= 1'b0;
		end
	
	OPCODE_NOP: begin 
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0,
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b0;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		if_jalr_en <= 1'b0;
		end

	default: begin
		shift_imm_sel <= 1'b0;
		s_imm_sel <= 1'b0,
		ex_branch <= 1'b0;
		ex_add2_sel <= `ADD2_IMM;
		ex_alu_op <= `ALU_OP_ADD;
		ex_pc_sel <= 1'b0;
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
