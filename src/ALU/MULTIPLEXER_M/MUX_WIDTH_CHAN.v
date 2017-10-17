// MULTIPLEXER
// Largely taken from https://alteraforum.com/forum/showthread.php?t=22519
// Modified by Trevor Gordon

module MUX_WIDTH_CHAN (out, sel, in_bus);
	parameter WIDTH= 8;
    parameter  CHANNELS= 4;

    input   [(CHANNELS*WIDTH)-1:0]      in_bus;
    input   [3:0]    sel;	// Couldn't get function to work with sel size
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


//define the clogb2 function
function integer clogb2;
  input depth;
  integer i,result;
  begin
    for (i = 0; 2 ** i < depth; i = i + 1)
      result = i + 1;
    clogb2 = result;
  end
endfunction

endmodule

