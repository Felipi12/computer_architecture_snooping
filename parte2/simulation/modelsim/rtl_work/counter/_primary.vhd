library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        clock           : in     vl_logic;
        q               : out    vl_logic_vector(1 downto 0)
    );
end counter;
