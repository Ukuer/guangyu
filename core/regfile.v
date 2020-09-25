`include "defines.v"

module regfile
(
	input [`RFIDX_WIDTH-1:0]	read_addr1,
	input [`RFIDX_WIDTH-1:0]	read_addr2,
	input [`RFIDX_WIDTH-1:0]	write_addr,
	input [`XLEN-1:0]			write_data,

	output [XLEN-1:0]			read_data1,
	output [XLEN-1:0]			read_data2

	input						reg_write,
	input						clk,
);

reg [`XLEN-1:0]		registers[2**`RFIDX_WIDTH:0];

always @(posedge clk)
begin : REGFILES_WIRITE
	if (reg_write == 1'b1)
		if (write_addr != {`RFIDX_WIDTH{0}})
				registers[write_addr] <= write_data;
end

always @(negedge clk)
begin : REGFILES_READ
	if (read_addr1 == {`RFIDX_WIDTH{0}})
		read_data1 <= {`XLEN{0}};
	else 
		read_data1 <= registers[read_addr1];
	
	if (read_addr2 == {`RFIDX_WIDTH{0}})
		read_data2 <= {`XLEN{0}};
	else 
		read_data2 <= registers[read_addr2];
end

endmodule
