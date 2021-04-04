//RM - Read Miss  |  RH - Read Hit  |  WM - Write Miss  |  WH - Write Hit

module parte1maq1(
  input [0:0] KEY,
  input [1:0] SW,
);

  // Processor States
  localparam Invalid = 2'b00;
  localparam Exclusive = 2'b01;
  localparam Shared = 2'b10;

  // Processor Messages
  localparam Place_Read_Miss_On_Bus = 3'b001;
  localparam Place_Invalidate_On_Bus = 3'b010;
  localparam Place_Write_Miss_On_Bus = 3'b011;

  localparam Write_Back_Block = 3'b100;
  localparam Write_Back_Cache_Block = 3'b101;

  localparam Empty = 3'b000;

  // Operations
  localparam RM = 2'b00;
  localparam RH = 2'b01;
  localparam WM = 2'b10;
  localparam WH = 2'b11;

  reg [1:0] state;
  reg [2:0] msg;

  initial
    state <= 1;

  always @(posedge KEY[0])
    case(state)
      Invalid:
        case(SW)
          RM, RH:
            begin
              state <= Shared;
              msg <= Place_Read_Miss_On_Bus;
            end
          WM, WH:
            begin
              state <= Exclusive;
              msg <= Place_Write_Miss_On_Bus;
            end
        endcase

      Exclusive:
        case(SW)
          WH, RH:
            begin
              state <= Exclusive;
              msg <= Empty;
            end
          WM:
            begin
              state <= Exclusive;
              msg <= Write_Back_Cache_Block;
            end
          RM:
            begin
              state <= Shared;
              msg <= Write_Back_Block;
            end
        endcase

      Shared:
        case(SW)
          RH:
            begin
              state <= Shared;
              msg <= Empty;
            end
          RM:
            begin
              state <= Shared;
              msg <= Place_Read_Miss_On_Bus;
            end
          WH:
            begin
              state <= Exclusive;
              msg <= Place_Invalidate_On_Bus;
            end
          WM:
            begin
              state <= Exclusive;
              msg <= Place_Write_Miss_On_Bus;
            end
        endcase
    endcase

endmodule