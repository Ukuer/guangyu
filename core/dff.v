/*
 * 
 *
 * the reset is asynchronous
 */

module dfflr #( 
	parameter WIDTH = 32
)(
	input					en,		// enbale sign
	input [WIDTH-1:0]		next,
	output [WIDTH-1:0]		qout,

	input					clk,
	input					rst_n,
);

reg [WIDTH-1:0]		q_r;	// the register

always @(posedge clk, negedge rst_n)
begin : DFFLR
	if (rst_n == 1'b0)
		q_r <= {WIDTH{1'b0}};
	else  if (en == 1'b1)
		q_r <= next;
end

assign qout = q_r;

endmodule 


module dfflrs #( 
	parameter WIDTH = 32
)(
	input					en,		
	input [WIDTH-1:0]		next,
	output [WIDTH-1:0]		qout,

	input					clk,
	input					rst_n,
);

reg [WIDTH-1:0]		q_r;	

always @(posedge clk, negedge rst_n)
begin : DFFLRS
	if (rst_n == 1'b0)
		q_r <= {WIDTH{1'b1}};
	else  if (en == 1'b1)
		q_r <= next;
end

assign qout = q_r;

endmodule 


module dffl #( 
	parameter WIDTH = 32
)(
	input					en,		
	input [WIDTH-1:0]		next,
	output [WIDTH-1:0]		qout,

	input					clk,
);

reg [WIDTH-1:0]		q_r;	

always @(posedge clk)
begin : DFFL
	if (en == 1'b1)
		q_r <= next;
end

assign qout = q_r;

endmodule 

module dffrs #( 
	parameter WIDTH = 32
)(
	input [WIDTH-1:0]		next,
	output [WIDTH-1:0]		qout,

	input					clk,
	input					rst_n,
);

reg [WIDTH-1:0]		q_r;	

always @(posedge clk, negedge rst_n)
begin : DFFRS
	if (rst_n == 1'b0)
		q_r <= {WIDTH{1'b1}};
	else 
		q_r <= next;
end

assign qout = q_r;
endmodule 



module dffr #( 
	parameter WIDTH = 32
)(
	input [WIDTH-1:0]		next,
	output [WIDTH-1:0]		qout,

	input					clk,
	input					rst_n,
);

reg [WIDTH-1:0]		q_r;	

always @(posedge clk, negedge rst_n)
begin : DFFR
	if (rst_n == 1'b0)
		q_r <= {WIDTH{1'b0}};
	else 
		q_r <= next;
end

assign qout = q_r;
endmodule 

module dff #( 
	parameter WIDTH = 32
)(
	input [WIDTH-1:0]		next,
	output [WIDTH-1:0]		qout,

	input					clk,
);

reg [WIDTH-1:0]		q_r;	

always @(posedge clk)
begin : DFF
		q_r <= next;
end

assign qout = q_r;
endmodule 
