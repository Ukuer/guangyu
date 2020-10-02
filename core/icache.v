`include "defines.v"
module icache
(
	input [`ADDR_SIZE-1:0]		addr,
	input						en,

	output reg [`INSTR_SIZE-1:0]	instr
);

reg [`INSTR_SIZE-1:0] instr_cache [2**10:0];

always @ (*)
	begin : I_CACHE 
		if (en)
			instr <= instr_cache[addr[12:3]];
	end

endmodule 
