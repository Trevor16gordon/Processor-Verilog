`ifndef _ADDER_N_BIT
`define _ADDER_N_BIT


`include "/Users/loreliegordon/Documents/UBCO/UBCO Year 4/ENGR 468 Advanced Digital Systems/Processor Project/src/ALU/FULL_ADDER/FULL_ADDER.v"

module ADDER_N_BIT(out, cout, in_a, in_b);
	parameter size = 4;
	input [size-1:0] in_a, in_b;
	output[size-1:0] out;
	output cout;

	wire [size:0] carry;
	assign carry[0] = 0;

	genvar i;
	generate
	for (i=0; i<size; i = i+1)
		begin
		FULL_ADDER my_adder(
			.sum(out[i]), 
			.cout(carry[i+1]), 
			.a(in_a[i]), 
			.b(in_b[i]), 
			.cin(carry[i])
			);
		end
	endgenerate

	assign cout = carry[size];


endmodule



`endif