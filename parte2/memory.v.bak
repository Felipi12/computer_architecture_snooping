module memory #(
  parameter FILE,
  parameter [1:0] ReadMiss,
  parameter [1:0] WriteBack
) (bus, q);

  input [7:0] bus;
  output reg [7:0] q;

  wire [1:0] estado, tag;
  wire [3:0] valor;

  assign estado = bus[7:6];
  assign tag = bus[5:4];
  assign valor = bus[3:0];

  // 4 x 4
  reg [3:0] memory [0:3]; 

  initial
    $readmemb(FILE, memory);

  always @(bus)
    if(estado == WriteBack)
      memory[tag] <= valor;
    else if(estado == ReadMiss)
      q <= memory[tag];

endmodule