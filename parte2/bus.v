module bus#(parameter ReadHit)(PC0, PC1, Memory, q);
  
  input [7:0] PC0, PC1, Memory,
  output reg [7:0] q;

  wire [7:0] defaults = {ReadHit, 2'b0, 4'b0};

  always@(*)
    if(PC0 != defaults)
      q <= PC0;
    else if(PC1 != defaults)
      q <= PC1;
    else
      q <= Memory;

endmodule