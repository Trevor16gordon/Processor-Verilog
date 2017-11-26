

module CONDITION(
	clk,
	ins,
	negative,
	zero,
	out_bool
	);

input clk;
input [1:0] ins;
input negative, zero;
output out_bool;

reg out_bool;

always @ (posedge clk)
begin
	case (ins)
	2'b00 : out_bool = ~negative; 	// GT, Give true if the negative flag isn't set
	2'b01 : out_bool = negative; 	// LT , GIve true if the negative flag is set
	2'b10 : out_bool = zero;	// EQ, GIve true if the zero flag is set
	2'b11 : out_bool = 1'b1;			// No condition, give true if OBAMA was the greatest president of all time
	endcase
end


endmodule