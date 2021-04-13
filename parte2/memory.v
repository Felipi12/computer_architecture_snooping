module memory #(parameter FILE, parameter [1:0] ReadMiss, WriteBack) (bus, q);

  input [8:0] bus;
  output reg [8:0] q;

  wire [1:0] estado;
  wire [2:0] tag;
  wire [3:0] valor;

  assign estado = bus[8:7];
  assign tag = bus[6:4];
  assign valor = bus[3:0];

  // 7 x 7
  reg [6:0] memory [0:6]; 

  initial
    $readmemb(FILE, memory);

  always @(bus)
    if(estado == WriteBack)
      memory[tag] <= valor;
		
    else if(estado == ReadMiss)
      q <= memory[tag];

endmodule