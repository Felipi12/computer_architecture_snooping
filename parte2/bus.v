module bus#(parameter ReadHit)(proc1, proc2, Memory, q);
  
  input [8:0] proc1, proc2, Memory;
  output reg [8:0] q;
  
  
  
  wire [8:0] Default = {ReadHit, 3'b0, 4'b0};

  always@(*)
    if(proc1 != Default)
      q <= proc1;
		
    else if(proc2 != Default)
      q <= proc2;
		
    else
      q <= Memory;

endmodule
