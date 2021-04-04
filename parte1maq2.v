//RM - Read Miss  |  RH - Read Hit  |  WM - Write Miss  |  WH - Write Hit

module parte1maq2 (
  input [0:0] KEY,
  input [1:0] SW,
);

  // Processor States
  localparam Invalid = 2'b00;
  localparam Exclusive = 2'b01;
  localparam Shared = 2'b10;

  // Processor Messages
  localparam Empty = 1'b0;
  localparam Write_Back_Block = 1'b1;

  // Operations
  localparam RM = 2'b00;
  localparam Invalidate = 2'b01;
  localparam WM = 2'b10;

  reg [1:0] state;
  reg msg;

  initial
    state <= 2;

  always @(posedge KEY[0])
    case(state)
      Invalid:
        begin
          state <= Invalid;
          msg <= Empty;
        end

      Exclusive:
        case(SW)
          WM:
            begin
              state <= Invalid;
              msg <= Write_Back_Block;
            end
          RM:
            begin
              state <= Shared;
              msg <= Write_Back_Block;
            end
          default:
            begin
              state <= Exclusive;
              msg <= Empty;
            end
        endcase

      Shared:
        case(SW)
          WM, Invalidate:
            begin
              state <= Invalid;
              msg <= Empty;
            end
          default:
            begin
              state <= Shared;
              msg <= Empty;
            end
        endcase
    endcase

endmodule