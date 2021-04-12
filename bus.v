module bus#(parameter ReadHit)(PC_0, PC_1, MEM, q);
  
  input [7:0] PC_0, PC_1, MEM,
  output reg [7:0] q;

  wire [7:0] defaults = {ReadHit, 2'b0, 4'b0};

  always@(*)
    if(PC_0 != defaults)
      q <= PC_0;
    else if(PC_1 != defaults)
      q <= PC_1;
    else
      q <= MEM;

endmodule