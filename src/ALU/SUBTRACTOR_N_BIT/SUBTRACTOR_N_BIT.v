`include "/Users/loreliegordon/Documents/UBCO/UBCO Year 4/ENGR 468 Advanced Digital Systems/Processor-Verilog/src/ALU/ADDER_N_BIT/ADDER_N_BIT.v"

module SUBTRACTOR_N_BIT(out, cout, overflow, in_a, in_b);
	parameter size = 4;
	input [size-1:0] in_a, in_b;
	output[size-1:0] out;
	output cout, overflow;

	
	ADDER_N_BIT #(.size(size)) my_sub(
		.out(out), 
		.overflow(overflow), 
		.in_a(in_a), 
		.cout(cout), 
		.in_b(~in_b+1'b1));
	

endmodule