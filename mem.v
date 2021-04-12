module mem #(
  parameter FILE,
  parameter [1:0] ReadMiss,
  parameter [1:0] WriteBack
) (
  input [7:0] bus,
  output reg [7:0] q
);

  wire [1:0] estado, tag;
  wire [3:0] valor;

  assign estado = bus[7:6];
  assign tag = bus[5:4];
  assign valor = bus[3:0];

  reg [3:0] mem [0:3]; // 4 x 4

  initial
    $readmemb(FILE, mem);

  always @(bus)
    if(estado == WriteBack)
      mem[tag] <= valor;
    else if(estado == ReadMiss)
      q <= mem[tag];

endmodule