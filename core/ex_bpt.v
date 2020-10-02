`include "defines.v"

module ex_bpt
(
	input			ex_branch,
	input	[2:0]		bxx_funct,

	input			alu_zero,
	input			alu_sign,
	input			alu_carry,

	input			take,

	input [`XLEN-1:0]	bxx_imm,

	output				bxx_flush,
	output				predict_fail,
	output [`XLEN-1:0]	fail_addr
);

reg correct;

always @(*)
begin
	case (bxx_funct)
		`B_EQ: begin
			correct <= alu_zero;
			end
		`B_NE: begin 
			correct <= ~ alu_zero;
			end 
		`B_LT: begin
			correct <= alu_sign;
			end
		`B_GE : begin 
			correct <= ~ alu_sign;
			end
		`B_LTU : begin 
			correct <= alu_carry;
			end
		`B_GEU : begin
			correct <= ~alu_carry;
			end 
		default: begin 
			correct <= 0;
			end 
	endcase
end 


assign predict_fail = (take ^ correct ) & ex_branch;
assign bxx_flush = predict_fail;

assign fail_addr = {`XLEN{~ bxx_imm[`XLEN-1]} }& bxx_imm;


endmodule








