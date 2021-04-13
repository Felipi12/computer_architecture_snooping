module parte1maq2 ( clock, SW );
  input clock;
  input [1:0] SW;

  //Possíveis operações
  localparam ReadMiss = 2'b00, Invalidate = 2'b01, WriteMiss = 2'b10;
  
  // Estados do Processador
  localparam Invalid = 2'b00, Exclusive = 2'b01, Shared = 2'b10;

  // Mensagens do Processador
  localparam Empty = 1'b0, Write_Back_Block = 1'b1;

 
  reg [1:0] estado;
  reg msg;

  initial
    estado <= 2;

  always @(posedge clock)
    case(estado)
      Invalid:
        begin
          estado <= Invalid;
          msg <= Empty;
        end

      Exclusive:
        case(SW)
          WriteMiss:
            begin
              estado <= Invalid;
              msg <= Write_Back_Block;
            end
          ReadMiss:
            begin
              estado <= Shared;
              msg <= Write_Back_Block;
            end
          default:
            begin
              estado <= Exclusive;
              msg <= Empty;
            end
        endcase

      Shared:
        case(SW)
          WriteMiss, Invalidate:
            begin
              estado <= Invalid;
              msg <= Empty;
            end
          default:
            begin
              estado <= Shared;
              msg <= Empty;
            end
        endcase
    endcase

endmodule