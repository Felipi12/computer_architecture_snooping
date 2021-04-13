module parte1maq1( clock, SW);
  input clock;
  input [1:0] SW;

  //Possíveis Operações
  localparam ReadMiss = 2'b00, ReadHit = 2'b01, WriteMiss = 2'b10, WriteHit = 2'b11;

  //Estados do Processador
  localparam Invalid = 2'b00, Exclusive = 2'b01, Shared = 2'b10;

  //Mensagens do Processador
  localparam Empty_Message = 2'b00;
  
  localparam Place_Read_Miss_On_Bus = 2'b01, Place_Invalidate_On_Bus = 2'b10, Place_Write_Miss_On_Bus = 2'b11;
  
  //Ações do Processador
  localparam Empty_Action = 2'b00, Write_Back_Block = 2'b01, Write_Back_Cache_Block = 2'b10;

  reg [1:0] estado;
  reg [1:0] mensagem, action;

  initial
    estado <= 0;

  always @(posedge clock)
    case(estado)
      Invalid:
        case(SW)
          ReadMiss, ReadHit:
            begin
              estado <= Shared;
              mensagem <= Place_Read_Miss_On_Bus;
				  action <= Empty_Action;
            end
          WriteMiss, WriteHit:
            begin
              estado <= Exclusive;
              mensagem <= Place_Write_Miss_On_Bus;
				  action <= Empty_Action;
            end
        endcase

      Exclusive:
        case(SW)
          WriteHit, ReadHit:
            begin
              estado <= Exclusive;
              mensagem <= Empty_Message;
				  action <= Empty_Action;
            end
          WriteMiss:
            begin
              estado <= Exclusive;
              mensagem <= Place_Write_Miss_On_Bus;
				  action <= Write_Back_Cache_Block;
            end
          ReadMiss:
            begin
              estado <= Shared;
              mensagem <= Place_Read_Miss_On_Bus;
				  action <= Write_Back_Block;
            end
        endcase

      Shared:
        case(SW)
          ReadHit:
            begin
              estado <= Shared;
              mensagem <= Empty_Message;
				  action <= Empty_Action;
            end
          ReadMiss:
            begin
              estado <= Shared;
              mensagem <= Place_Read_Miss_On_Bus;
				  action <= Empty_Action;
            end
          WriteHit:
            begin
              estado <= Exclusive;
              mensagem <= Place_Invalidate_On_Bus;
				  action <= Empty_Action;
            end
          WriteMiss:
            begin
              estado <= Exclusive;
              mensagem <= Place_Write_Miss_On_Bus;
				  action <= Empty_Action;
            end
        endcase
    endcase

endmodule
