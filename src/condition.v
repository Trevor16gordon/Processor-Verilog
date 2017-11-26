

module CONDITION(
	clk,
	ins,
	in_a,
	in_b,
	out_bool
	);

input clk;
input [1:0] ins;
input [15:0] in_a, in_b;
output out_bool;

reg out_bool;

always @ (posedge clk)
begin
	case (ins)
	2'b00 : out_bool = (in_a > in_b);
	2'b01 : out_bool = (in_a < in_b);
	2'b10 : out_bool = (in_a == in_b);
	2'b11 : out_bool = 1'b1;
	endcase
end


endmodule