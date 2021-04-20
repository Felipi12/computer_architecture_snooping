library verilog;
use verilog.vl_types.all;
entity \bus\ is
    generic(
        ReadHit         : vl_notype
    );
    port(
        proc1           : in     vl_logic_vector(8 downto 0);
        proc2           : in     vl_logic_vector(8 downto 0);
        Memory          : in     vl_logic_vector(8 downto 0);
        q               : out    vl_logic_vector(8 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ReadHit : constant is 5;
end \bus\;
