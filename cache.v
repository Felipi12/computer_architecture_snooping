module cache #(
  parameter NAME, FILE,
  parameter ReadMiss, ReadHit, WriteBack
) (
  input [1:0] passo,
  input [8:0] instruction,
  input [7:0] InBus,
  output reg [7:0] OutBus,
  output reg [7:0] q
);

  localparam [1:0] Invalid = 0, Shared = 1, Modified = 2;

  reg [7:0] memory [0:1];  // 2 x 8

  wire iOp, iThis, iIndex;
  wire [1:0] iTag, aTag, aState, bType, bTag;
  wire [3:0] iValue, aValue, bValue;

  assign iOp = instruction[8];                 // 0: LOAD                          1: STORE
  assign iThis = instruction[7:6] == NAME;     // 0: origem e outro processador    1: origem e este processador
  assign iTag = instruction[5:4];              // TAG da instrucao
  assign iValue = instruction[3:0];            // Valor a ser escrito

  assign iIndex = iTag[0];

  assign aState = memory[iIndex][7:6];
  assign aTag = memory[iIndex][5:4];
  assign aValue = memory[iIndex][3:0];

  assign bType = InBus[7:6];
  assign bTag = InBus[5:4];
  assign bValue = InBus[3:0];

  initial
    $readmemb(FILE, memory);

  always @(passo) begin
    OutBus = {ReadHit, 2'b0, 4'b0};
    case(passo)
      2'b00:
        if(iThis) begin
          // MISS
          if(aTag != iTag || aState == Invalid) begin
            // Modified STATE
            if(aState == Modified) begin
              OutBus = {WriteBack, aTag, aValue};
            end
          end
        end

      2'b01:
        if(iThis) begin
          // WRITE
          if(iOp) begin
            memory[iIndex] = {Modified, iTag, iValue};
            OutBus = {Invalid, iTag, 4'b0};

          // READ
          end else begin
            // MISS
            if(aTag != iTag || aState == Invalid)
              OutBus = {ReadMiss, iTag, 4'b0};
            else
              OutBus = {ReadHit, iTag, 4'b0};
          end
        end

      2'b10:
        if(!iThis) begin
          // WRITE
          if(iOp) begin

            // HIT
            if(aTag == iTag) begin
              if(aState == Modified)
                OutBus = {WriteBack, aTag, aValue};

              memory[iIndex][7:6] = Invalid;
            end

          // READ
          end else begin

            // MISS
            if(bType == ReadMiss) // informacao pode estar desatualizada
              if(aTag == iTag && aState != Invalid) begin
                OutBus = {WriteBack, aTag, aValue};
                memory[iIndex][7:6] = Shared;
              end
          end
        end

      default: begin
        if(iThis) begin
          // READ
          if(!iOp) begin

            // MISS
            if(aTag != iTag || aState == Invalid) begin
              memory[iIndex] = {Shared, bTag, bValue};
            end
            q = memory[iIndex];
          end
        end else
       end
     endcase
   end

endmodule