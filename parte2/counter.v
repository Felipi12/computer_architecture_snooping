module counter (clock, q);
  input clock;
  output reg [1:0] q;

  initial
    q <= 0;

  always @(posedge clock)
    q <= q + 1'b1;

endmodule
