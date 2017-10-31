// MULTIPLEXER
// Largely taken from https://alteraforum.com/forum/showthread.php?t=22519
// Modified by Trevor Gordon

module MUX_WIDTH_CHAN (out, sel, in_bus);
	
    parameter WIDTH= 8;
    parameter  CHANNELS= 4;
    parameter SEL_LENGTH = 2;

    input   [(CHANNELS*WIDTH)-1:0]      in_bus;
    input   [SEL_LENGTH-1:0]    sel;	
    //input [2:0] sel;

    output  [WIDTH-1:0]                 out;
 

genvar ig;
    
wire    [WIDTH-1:0] input_array [0:CHANNELS-1];

assign  out = input_array[sel];

generate
    for(ig=0; ig<CHANNELS; ig=ig+1) begin: array_assignments
        assign  input_array[ig] = in_bus[(ig*WIDTH)+:WIDTH];
    end
endgenerate


endmodule

