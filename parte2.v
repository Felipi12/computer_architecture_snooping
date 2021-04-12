module parte2(KEY, SW, LEDR);

  input [0:0] KEY;
  input [17:9] SW;
  output [17:9] LEDR;

  // intruction => op [1] | proc [2] | tag [2] | value [4] = 9 bits

  localparam [1:0] PC_0 = 0, PC_1 = 1;
  localparam ReadMiss = 1, ReadHit = 2, WriteBack = 3;

  wire [1:0] step;
  wire [7:0] cache_0_out, cache_1_out, mem_out, bus_out;
  wire [7:0] q0, q1;

  counter cnt (
    .clock(KEY[0]),
    .q(step)
  );

  cache #(
    .NAME(PC_0), .FILE("C:/altera/LAOCII/Pratica_04/parte_2/cache_0.mem"),
    .ReadMiss(ReadMiss), .ReadHit(ReadHit), .WriteBack(WriteBack)
    ) Cache0 (
    .step(step),
    .instruction(SW),
    .bus_in(bus_out),
    .bus_out(cache_0_out),
    .q(q0)
  );

  cache #(
    .NAME(PC_1), .FILE("C:/altera/LAOCII/Pratica_04/parte_2/cache_1.mem"),
    .ReadMiss(ReadMiss), .ReadHit(ReadHit), .WriteBack(WriteBack)
    ) Cache1 (
    .step(step),
    .instruction(SW),
    .bus_in(bus_out),
    .bus_out(cache_1_out),
    .q(q1)
  );


  memory #(
    .FILE("C:/altera/LAOCII/Pratica_04/parte_2/mem.mem"),
    .ReadMiss(ReadMiss),
    .WriteBack(WriteBack)
  ) MEM (
    .bus(bus_out),
    .q(mem_out)
  );

  bus #(
    .ReadHit(ReadHit)
  ) BUS (
    .PC_0(cache_0_out),
    .PC_1(cache_1_out),
    .MEM(mem_out),
    .q(bus_out)
  );

  assign LEDR = SW;

endmodule