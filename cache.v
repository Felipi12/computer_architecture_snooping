module cache #(
  parameter NAME, FILE,
  parameter RM, RH, WB
) (
  input [1:0] step,
  input [8:0] instruction,
  input [7:0] bus_in,
  output reg [7:0] bus_out,
  output reg [7:0] q
);

  localparam [1:0] INVALID = 0, SHARED = 1, MODIFIED = 2;

  reg [7:0] mem [0:1];  // 2 x 8

  wire iOp, iThis, iIndex;
  wire [1:0] iTag, aTag, aState, bType, bTag;
  wire [3:0] iValue, aValue, bValue;

  assign iOp = instruction[8];                 // 0: LOAD                          1: STORE
  assign iThis = instruction[7:6] == NAME;     // 0: origem e outro processador    1: origem e este processador
  assign iTag = instruction[5:4];              // TAG da instrucao
  assign iValue = instruction[3:0];            // Valor a ser escrito

  assign iIndex = iTag[0];

  assign aState = mem[iIndex][7:6];
  assign aTag = mem[iIndex][5:4];
  assign aValue = mem[iIndex][3:0];

  assign bType = bus_in[7:6];
  assign bTag = bus_in[5:4];
  assign bValue = bus_in[3:0];

  initial
    $readmemb(FILE, mem);

  always @(step) begin
    bus_out = {RH, 2'b0, 4'b0};
    case(step)
      2'b00:
        if(iThis) begin
          // MISS
          if(aTag != iTag || aState == INVALID) begin
            // MODIFIED STATE
            if(aState == MODIFIED) begin
              bus_out = {WB, aTag, aValue};
            end
          end
        end

      2'b01:
        if(iThis) begin
          // WRITE
          if(iOp) begin
            mem[iIndex] = {MODIFIED, iTag, iValue};
            bus_out = {INVALID, iTag, 4'b0};

          // READ
          end else begin
            // MISS
            if(aTag != iTag || aState == INVALID)
              bus_out = {RM, iTag, 4'b0};
            else
              bus_out = {RH, iTag, 4'b0};
          end
        end

      2'b10:
        if(!iThis) begin
          // WRITE
          if(iOp) begin

            // HIT
            if(aTag == iTag) begin
              if(aState == MODIFIED)
                bus_out = {WB, aTag, aValue};

              mem[iIndex][7:6] = INVALID;
            end

          // READ
          end else begin

            // MISS
            if(bType == RM) // informacao pode estar desatualizada
              if(aTag == iTag && aState != INVALID) begin
                bus_out = {WB, aTag, aValue};
                mem[iIndex][7:6] = SHARED;
              end
          end
        end

      default: begin
        if(iThis) begin
          // READ
          if(!iOp) begin

            // MISS
            if(aTag != iTag || aState == INVALID) begin
              mem[iIndex] = {SHARED, bTag, bValue};
            end
            q = mem[iIndex];
          end
        end else
       end
     endcase
   end

endmodule