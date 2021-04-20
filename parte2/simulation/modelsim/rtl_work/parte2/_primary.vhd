library verilog;
use verilog.vl_types.all;
entity parte2 is
    port(
        clock           : in     vl_logic;
        Instruc         : in     vl_logic_vector(9 downto 0)
    );
end parte2;
