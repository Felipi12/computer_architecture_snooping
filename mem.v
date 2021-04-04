module mem #(
  parameter FILE,
  parameter [1:0] RM,
  parameter [1:0] WB
) (
  input [7:0] bus,
  output reg [7:0] q
);

  wire [1:0] state, tag;
  wire [3:0] value;

  assign state = bus[7:6];
  assign tag = bus[5:4];
  assign value = bus[3:0];

  reg [3:0] mem [0:3]; // 4 x 4

  initial
    $readmemb(FILE, mem);

  always @(bus)
    if(state == WB)
      mem[tag] <= value;
    else if(state == RM)
      q <= mem[tag];

endmodule