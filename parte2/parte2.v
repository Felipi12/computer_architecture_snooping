module parte2(clock, Instruc);

  input clock;
  input [9:0] Instruc;

  // Cada instrução é dividida da seguinte maneira:
  // Op    1 bit    X---------
  // proc  2 bits   -XX-------
  // tag   3 bits   ---XXX----
  // valor 4 bits   ------XXXX
  // TOTAL 10 bits

  localparam [1:0] proc1 = 2'b00, proc2 = 2'b01;
  localparam [1:0] ReadMiss = 2'b01, ReadHit = 2'b10, WriteBack = 2'b11;

  wire [1:0] step;
  wire [8:0] OutCache1, OutCache2, OutMemory, OutBus;
  wire [8:0] q1, q2;

  counter cnt (
    .clock(clock),
    .q(step)
  );

  cache #(
    // COMPLETAR AQUI
    .NAME(proc1), .FILE("C:/Users/mariz/Desktop/LAOC II/pratica4/parte2/cache1.mem"),
    .ReadMiss(ReadMiss), .ReadHit(ReadHit), .WriteBack(WriteBack)
    ) cache1 (
    .step(step),
    .instruction(Instruc),
    .InBus(OutBus),
    .OutBus(OutCache1),
    .q(q1)
  );

  cache #(
    // COMPLETAR AQUI
    .NAME(proc2), .FILE("C:/Users/mariz/Desktop/LAOC II/pratica4/parte2/cache2.mem"),
    .ReadMiss(ReadMiss), .ReadHit(ReadHit), .WriteBack(WriteBack)
    ) cache2 (
    .step(step),
    .instruction(Instruc),
    .InBus(OutBus),
    .OutBus(OutCache2),
    .q(q2)
  );


  memory #(
    // COMPLETAR AQUI
    .FILE("C:/Users/mariz/Desktop/LAOC II/pratica4/parte2/memo.mem"),
    .ReadMiss(ReadMiss),
    .WriteBack(WriteBack)
  ) Memo (
    .bus(OutBus),
    .q(OutMemory)
  );

  bus #(
    .ReadHit(ReadHit)
  ) Bus_data (
    .proc1(OutCache1),
    .proc2(OutCache2),
    .Memory(OutMemory),
    .q(OutBus)
  );

endmodule
