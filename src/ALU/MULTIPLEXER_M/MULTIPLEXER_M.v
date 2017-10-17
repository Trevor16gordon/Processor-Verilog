// MULTIPLEXER
// Largely taken from https://alteraforum.com/forum/showthread.php?t=22519
// Modified by Trevor Gordon

module MUX_WIDTH_CHAN (
	#parameter  WIDTH           = 32,
    #parameter  CHANNELS        = 10) 
(

    input   [(CHANNELS*WIDTH)-1:0]      in_bus,
    input   [clogb2(CHANNELS-1)-1:0]    sel,   
    output  [WIDTH-1:0]                 out
    );

genvar ig;    
wire    [WIDTH-1:0] input_array [0:CHANNELS-1];

assign  out = input_array[sel];

generate
    for(ig=0; ig<CHANNELS; ig=ig+1) begin: array_assignments
        assign  input_array[ig] = in_bus[(ig*WIDTH)+:WIDTH];
    end
endgenerate


//define the clogb2 function
// This function will give a num_bits that 
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

