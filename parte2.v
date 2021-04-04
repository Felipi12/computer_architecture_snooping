module parte2(KEY, SW, LEDR, HEX0);

  input [0:0] KEY;
  input [17:9] SW;
  output [0:6] HEX0;
  output [17:9] LEDR;

  // intruction => op [1] | proc [2] | tag [2] | value [4] = 9 bits

  localparam [1:0] PC_0 = 0, PC_1 = 1, PC_2 = 2;
  localparam RM = 1, RH = 2, WB = 3;

  wire [1:0] step;
  wire [7:0] cache_0_out, cache_1_out, cache_2_out, mem_out, bus_out;
  wire [7:0] q0, q1, q2;

  counter cnt (
    .clock(KEY[0]),
    .q(step)
  );

  cache #(
    .NAME(PC_0), .FILE("C:/altera/LAOCII/Pratica_04/parte_2/cache_0.mem"),
    .RM(RM), .RH(RH), .WB(WB)
    ) Cache0 (
    .step(step),
    .instruction(SW),
    .bus_in(bus_out),
    .bus_out(cache_0_out),
    .q(q0)
  );

  cache #(
    .NAME(PC_1), .FILE("C:/altera/LAOCII/Pratica_04/parte_2/cache_1.mem"),
    .RM(RM), .RH(RH), .WB(WB)
    ) Cache1 (
    .step(step),
    .instruction(SW),
    .bus_in(bus_out),
    .bus_out(cache_1_out),
    .q(q1)
  );

  cache #(
    .NAME(PC_2), .FILE("C:/altera/LAOCII/Pratica_04/parte_2/cache_2.mem"),
    .RM(RM), .RH(RH), .WB(WB)
    ) Cache2 (
    .step(step),
    .instruction(SW),
    .bus_in(bus_out),
    .bus_out(cache_2_out),
    .q(q2)
  );


  memory #(
    .FILE("C:/altera/LAOCII/Pratica_04/parte_2/mem.mem"),
    .RM(RM),
    .WB(WB)
  ) MEM (
    .bus(bus_out),
    .q(mem_out)
  );

  bus #(
    .RH(RH)
  ) BUS (
    .PC_0(cache_0_out),
    .PC_1(cache_1_out),
    .PC_2(cache_2_out),
    .MEM(mem_out),
    .q(bus_out)
  );

  assign LEDR = SW;

endmodule