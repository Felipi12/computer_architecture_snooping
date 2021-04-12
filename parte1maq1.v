module parte1maq1( clock, SW);
  input clock;
  input [1:0] SW;

  //Possíveis Operações
  localparam ReadMiss = 2'b00, ReadHit = 2'b01, WriteMiss = 2'b10, WriteHit = 2'b11;

  //Estados do Processador
  localparam Invalid = 2'b00, Exclusive = 2'b01, Shared = 2'b10;

  //Mensagens do Processador
  localparam Place_Read_Miss_On_Bus = 3'b001, Place_Invalidate_On_Bus = 3'b010, Place_Write_Miss_On_Bus = 3'b011;

  localparam Write_Back_Block = 3'b100, Write_Back_Cache_Block = 3'b101;

  localparam Empty = 3'b000;

  reg [1:0] estado;
  reg [2:0] mensagem;

  initial
    estado <= 1;

  always @(posedge clock)
    case(estado)
      Invalid:
        case(SW)
          ReadMiss, ReadHit:
            begin
              estado <= Shared;
              mensagem <= Place_Read_Miss_On_Bus;
            end
          WriteMiss, WriteHit:
            begin
              estado <= Exclusive;
              mensagem <= Place_Write_Miss_On_Bus;
            end
        endcase

      Exclusive:
        case(SW)
          WriteHit, ReadHit:
            begin
              estado <= Exclusive;
              mensagem <= Empty;
            end
          WriteMiss:
            begin
              estado <= Exclusive;
              mensagem <= Write_Back_Cache_Block;
            end
          ReadMiss:
            begin
              estado <= Shared;
              mensagem <= Write_Back_Block;
            end
        endcase

      Shared:
        case(SW)
          ReadHit:
            begin
              estado <= Shared;
              mensagem <= Empty;
            end
          ReadMiss:
            begin
              estado <= Shared;
              mensagem <= Place_Read_Miss_On_Bus;
            end
          WriteHit:
            begin
              estado <= Exclusive;
              mensagem <= Place_Invalidate_On_Bus;
            end
          WriteMiss:
            begin
              estado <= Exclusive;
              mensagem <= Place_Write_Miss_On_Bus;
            end
        endcase
    endcase

endmodule