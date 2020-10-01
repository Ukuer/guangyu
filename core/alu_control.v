`include "defines.v"

module alu_control
(
	input [1:0]				ex_alu_op,
	input [3:0]				alu_funct,

	output [3:0]			alu_sel,
);

always @(*)
begin
	case (ex_alu_op) begin

	`ALU_OP_R: begin 
		alu_sel <= alu_funct;
	end 
	`ALU_OP_I: begin 
		alu_sel[2:0] <= alu_funct[2:0];
		alu_sel[3] <= (alu_funct == `ALU_SUB) 1'b0 :
						alu_funct[3];
	end 
	`ALU_OP_ADD: begin 
		alu_sel <= `ALU_ADD;
	end 
	`ALU_OP_SUB: begin 
		alu_sel <= `ALU_SUB;
	end 
	default: begin 
		alu_sel <= alu_funct;
	end 

	endcase
end 

endmodule

