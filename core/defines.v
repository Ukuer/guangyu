
`define ADDR_SIZE	32
`define PC_SIZE		32
`define INSTR_SIZE	32

`define XLEN		32		// the length of register 
`define RFIDX_WIDTH		5		// the index of regfile 
`define RF_NUM		32

// instruction formats
`define RANGE_OP	6:0
`define RANGE_RD	11:7
`define RANGE_RS1	19:15
`define RANGE_RS2	24:20
`define RANGE_F3	14:12
`define RANGE_F7	31:25
`define RANGE_IMM12	31:20

`define RANGE_S_IMM4	11:7
`define RANGE_S_IMM11	31:25

`define RANGE_B_IMM4	11:8
`define RANGE_B_IMM10	30:25
`define RANGE_B_IMM11	7
`define RANGE_B_IMM12	31

`define RANGE_U_IMM		31:12
`define RANGE_J_IMM10	30:21
`define RANGE_J_IMM11	20
`define RANGE_J_IMM19	19:12
`define RANGE_J_IMM20	31
`define RANGE_SHAMT		24:20

// opcode
`define	OPCODE_R_TYPE	7'b0110011
`define OPCODE_IA_TYPE	7'b0010011
`define OPCODE_ID_TYPE	7'b0000011
`define OPCODE_IF_TYPE	7'b0001111
`define OPCODE_IE_TYPE	7'b1110011
`define OPCODE_B_TYPE	7'b1100011
`define OPCODE_JALR		7'b1100111
`define OPCODE_JAL		7'b1101111
`define OPCODE_LUI		7'b0110111
`define OPCODE_AUIPC	7'b0010111
`define OPCODE_S_TYPE	7'b0100011
