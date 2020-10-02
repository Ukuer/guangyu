`include "defines.v"

module dcache
(
	input [`XLEN-1:0]		addr,
	input [`XLEN-1:0]		data_in,

	input [2:0]				mode,

	input					write_en,
	input					read_en,

	output reg[`XLEN-1:0]					data_out
);

parameter ADDR_OFFSET = 32'h10000;

wire[31:0] offset = addr - `ADDR_SIZE;

wire [10:0]	index_addr = offset[10:0];

reg [7:0]	dcache_reg[2**10-1:0];

always @(*)
begin	
	if (write_en) begin 
		case (mode)
			`MEM_MODE_B:begin 
				dcache_reg[index_addr] <= data_in[7:0];
				end
			`MEM_MODE_H:begin
				dcache_reg[index_addr] <= data_in[7:0];
				dcache_reg[index_addr+1] <= data_in[15:8];
				end
			`MEM_MODE_W: begin
				dcache_reg[index_addr] <= data_in[7:0];
				dcache_reg[index_addr+1] <= data_in[15:8];
				dcache_reg[index_addr+2] <= data_in[23:16];
				dcache_reg[index_addr+3] <= data_in[31:24];
				end 
			default: begin
				end 
			endcase
		end 
	else if (read_en) begin 
		case (mode)
			`MEM_MODE_B:begin 
				data_out <= {{24{dcache_reg[index_addr][7]}}, dcache_reg[index_addr]};
				end
			`MEM_MODE_H:begin
				data_out <= {{16{dcache_reg[index_addr+1][7]}}, dcache_reg[index_addr+1], dcache_reg[index_addr]};
				end
			`MEM_MODE_W: begin
				data_out <= {dcache_reg[index_addr+3],dcache_reg[index_addr+2],dcache_reg[index_addr+1],dcache_reg[index_addr]};
				end 
			`MEM_MODE_BU:begin 
				data_out <= {{24{1'b0}}, dcache_reg[index_addr]};
				end
			`MEM_MODE_HU:begin
				data_out <= {{16{1'b0}}, dcache_reg[index_addr+1], dcache_reg[index_addr]};
				end
			default: begin
				data_out <= 32'b0;
				end 
			endcase
		end 

	else  begin 
		end 
end 

endmodule 
