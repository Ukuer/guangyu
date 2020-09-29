`include "defines.v"

module control
(
	input [6:0]		opcode,
	input [3:0]			shift_funct4,

	output			shift_imm_sel,

	output			ex_branch,
	output[1:0]		ex_aluop,
	output			ex_alu_imm_sel,
	
	output			wb_reg_write,
	output			wb_memtoreg,

	output			m_mem_read,
	output			m_mem_write,

);

reg [6:0] opcode;

always @(*)
begin
	case(opcode):begin
	
	OPCODE_R_TYPE:	begin 
		shift_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_aluop <= 2'b10;
		ex_alu_imm_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		end
	OPCODE_IA_TYPE: begin
		if (shift_funct4 == 4'b0001 ||
			shift_funct4 == 4'b0101 ||
			shift_funct4 == 4'b1101)
			
			shift_imm_sel <= 1'b1;
		else 
			shift_imm_sel <= 1'b0;

		ex_branch <= 1'b0;
		ex_aluop <= 2'b11;
		ex_alu_imm_sel <= 1'b1;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		end
		
		OPCODE_ID_TYPE: begin 
		shift_imm_sel <= 1'b0;
		ex_branch <= 1'b0;
		ex_aluop <= 2'b01;
		ex_alu_imm_sel <= 1'b0;
		wb_reg_write <= 1'b1;
		wb_memtoreg <= 1'b1;
		m_mem_read <= 1'b1;
		m_mem_write <= 1'b0;
		end
		
		OPCODE_B_TYPE: begin
		shift_imm_sel <= 1'b0;
		ex_branch <= 1'b1;
		ex_aluop <= 2'b10;		// wait
		ex_alu_imm_sel <= 1'b1;
		wb_reg_write <= 1'b0;
		wb_memtoreg <= 1'b0;
		m_mem_read <= 1'b0;
		m_mem_write <= 1'b0;
		end

