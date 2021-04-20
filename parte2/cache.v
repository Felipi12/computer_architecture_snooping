module cache #(
  parameter NAME, FILE,
  parameter [1:0] ReadMiss, ReadHit, WriteBack
) (
  input [1:0] step,
  input [9:0] instruction,
  input [8:0] InBus,
  output reg [8:0] OutBus,
  output reg [8:0] q
);

  localparam [1:0] Invalid = 2'b00, Shared = 2'b01, Modified = 2'b10;
  
  // 4 x EETTTDDDD 
  // E- Estado    T- Tag    D- Dado a ser escrito
  reg [8:0] memory [0:3];  

  wire Op_instruc, EsseProc;
  wire [1:0] Estado_cache, Tipo_Bus, Bloco;
  wire [2:0] Tag_instruc, Tag_cache, Tag_Bus;
  wire [3:0] Valor_instruc, Valor_cache, Valor_Bus;
							
							
  // Dados da Intrucao (Input)         					// Se o valor for:	
  assign Op_instruc = instruction[9];                 // 0 - Instrução de Load (Read)          1 - Instrução de Store (Write)
  assign EsseProc = (instruction[8:7] == NAME);       // 0 - A origem é o outro processador    1 - A origem é o processador atual
  assign Tag_instruc = instruction[6:4];              // TAG da instrucao
  assign Valor_instruc = instruction[3:0];            // Valor a ser escrito

  
  // Dados da Cache
  assign Bloco = Tag_instruc[1:0];

  assign Estado_cache = memory[ Bloco ][8:7];
  assign Tag_cache = memory[ Bloco ][6:4];
  assign Valor_cache = memory[ Bloco ][3:0];

  
  // Dados do barramento Bus
  assign Tipo_Bus = InBus[8:7];
  assign Tag_Bus = InBus[6:4];
  assign Valor_Bus = InBus[3:0];

  initial
    $readmemb(FILE, memory);

  always @(step) begin
    OutBus = {ReadHit, 3'b0, 4'b0};
	 
    case(step)
	 
      2'b00:
        if(EsseProc) begin
          // MISS
          if(Tag_cache != Tag_instruc || Estado_cache == Invalid) begin
			 
            // Para estado Modified 
            if(Estado_cache == Modified) begin
              OutBus = {WriteBack, Tag_cache, Valor_cache};
            end

          end
        end

      2'b01:
        if(EsseProc) begin
          // WRITE
          if(Op_instruc) begin
            memory[Bloco] = {Modified, Tag_instruc, Valor_instruc};
            OutBus = {Invalid, Tag_instruc, 4'b0};

          // READ
          end else begin
            // MISS
            if(Tag_cache != Tag_instruc || Estado_cache == Invalid)
              OutBus = {ReadMiss, Tag_instruc, 4'b0};
				// HIT
            else
              OutBus = {ReadHit, Tag_instruc, 4'b0};
				  
          end
        end

      2'b10:
        if(!EsseProc) begin
          // WRITE
          if(Op_instruc) begin

            // HIT
            if(Tag_cache == Tag_instruc) begin
              if(Estado_cache == Modified)
                OutBus = {WriteBack, Tag_cache, Valor_cache};

              memory[Bloco][8:7] = Invalid;
            end

          // READ
          end else begin

            // MISS
            if(Tipo_Bus == ReadMiss) // informacao pode estar desatualizada
              if(Tag_cache == Tag_instruc && Estado_cache != Invalid) begin
                OutBus = {WriteBack, Tag_cache, Valor_cache};
                memory[Bloco][8:7] = Shared;
              end
				  
          end
        end

      default: begin
        if(EsseProc) begin
          // READ
          if(!Op_instruc) begin

            // MISS
            if(Tag_cache != Tag_instruc || Estado_cache == Invalid) begin
              memory[Bloco] = {Shared, Tag_Bus, Valor_Bus};
            end
				
            q = memory[Bloco];
          end
        end 
       end
     endcase
   end

endmodule
