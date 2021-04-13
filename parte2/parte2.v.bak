module parte2(clock, SW);

  input clock
  input [17:9] SW;

  // Cada instrução é dividida da seguinte maneira => op [1] | proc [2] | tag [2] | value [4] = 9 bits

  localparam [1:0] PC0 = 0, PC1 = 1;
  localparam ReadMiss = 1, ReadHit = 2, WriteBack = 3;

  wire [1:0] passo;
  wire [7:0] OutCache1, OutCache2, OutMemory, OutBus;
  wire [7:0] q0, q1;

  counter cnt (
    .clock(clock),
    .q(passo)
  );

  cache #(
    // COMPLETAR AQUI
    .NAME(PC0), .FILE("C:/altera/LAOCII/Pratica_04/parte_2/cache"),
    .ReadMiss(ReadMiss), .ReadHit(ReadHit), .WriteBack(WriteBack)
    ) cache1 (
    .passo(passo),
    .instruction(SW),
    .InBus(OutBus),
    .OutBus(OutCache1),
    .q(q0)
  );

  cache #(
    // COMPLETAR AQUI
    .NAME(PC1), .FILE("C:/altera/LAOCII/Pratica_04/parte_2/cache"),
    .ReadMiss(ReadMiss), .ReadHit(ReadHit), .WriteBack(WriteBack)
    ) cache2 (
    .passo(passo),
    .instruction(SW),
    .InBus(OutBus),
    .OutBus(OutCache2),
    .q(q1)
  );


  memory #(
    // COMPLETAR AQUI
    .FILE("C:/altera/LAOCII/Pratica_04/parte_2/cache"),
    .ReadMiss(ReadMiss),
    .WriteBack(WriteBack)
  ) MEM (
    .bus(OutBus),
    .q(OutMemory)
  );

  bus #(
    .ReadHit(ReadHit)
  ) BUS (
    .PC0(OutCache1),
    .PC1(OutCache2),
    .MEM(OutMemory),
    .q(OutBus)
  );

endmodule