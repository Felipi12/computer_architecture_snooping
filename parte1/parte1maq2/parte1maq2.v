module parte1maq2 ( clock, SW );
  input clock;
  input [1:0] SW;

  //Possíveis operações
  localparam ReadMiss = 2'b00, Invalidate = 2'b01, WriteMiss = 2'b10;
  
  //Estados do Processador
  localparam Invalid = 2'b00, Exclusive = 2'b01, Shared = 2'b10;
  
  //Ações do Processador
  localparam Empty = 1'b0, Write_Back_Block = 1'b1;


  reg [1:0] estado;
  reg action;

  initial
    estado <= 2;

  always @(posedge clock)
    case(estado)
      Invalid:
        begin
          estado <= Invalid;
          action <= Empty;
        end

      Exclusive:
        case(SW)
          WriteMiss:
            begin
              estado <= Invalid;
              action <= Write_Back_Block;
            end
          ReadMiss:
            begin
              estado <= Shared;
              action <= Write_Back_Block;
            end
        endcase

      Shared:
        case(SW)
          WriteMiss, Invalidate:
            begin
              estado <= Invalid;
              action <= Empty;
            end
          ReadMiss:
            begin
              estado <= Shared;
              action <= Empty;
            end
        endcase
    endcase

endmodule
