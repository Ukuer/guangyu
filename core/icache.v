`include "defines.v"
module icache
(
	input [`ADDR_SIZE-1:0]		addr,
	output [`INSTR_SIZE-1:0]	instr,
);

assign instr = addr + 1;

endmodule 
