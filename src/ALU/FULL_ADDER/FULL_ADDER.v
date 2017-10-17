`ifndef _FULL_ADDER
`define _FULL_ADDER


module FULL_ADDER(sum, cout, a, b, cin);
	input a, b, cin;
	output sum, cout;

	assign sum = ^{a,b,cin};
	assign cout = a&b | a&cin | b&cin;
endmodule


`endif