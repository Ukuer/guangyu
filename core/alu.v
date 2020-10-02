`include "defines.v"

module alu
(
	input [`XLEN-1:0]	add1,
	input [`XLEN-1:0]	add2,

	input [3:0]			alu_sel,

	output reg[`XLEN-1:0]	sum,
	output 				zero,
	output 				sign,
	output reg 				carry
);

assign zero = ~(| sum);
assign sign = sum[`XLEN-1];

always @(*)
begin
	case(alu_sel) 
		
		`ALU_ADD: begin 
			{carry, sum} <= add1 + add2;
			end 
		`ALU_SUB: begin 
			{carry, sum} <= add1 + add2;
			end 
		`ALU_SLL: begin 
			sum <= add1 << add2 ;
			end
		`ALU_SLT: begin
			sum <= (add1[`XLEN-1] ^ add2[`XLEN-1]) ? add2[`XLEN-1] : (add1 < add2);
			end 
		`ALU_SLTU: begin 
			sum <= add1 < add2;
			end 
		`ALU_XOR: begin 
			sum <= add1 ^ add2;
			end 
		`ALU_SRL : begin 
			sum <= add1 >> add2 ;
			end
		`ALU_SRA: begin 
			sum <= add1 >>> add2 ;
			end
		`ALU_OR: begin 
			sum <= add1 | add2;
			end 
		`ALU_AND: begin 
			sum <= add1 & add2;
			end 

		default: begin 
			sum <= `XLEN'b0;
			end 

	endcase

end 


endmodule
