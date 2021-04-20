library verilog;
use verilog.vl_types.all;
entity cache is
    generic(
        NAME            : vl_notype;
        \FILE\          : vl_notype;
        ReadMiss        : vl_logic_vector(1 downto 0);
        ReadHit         : vl_logic_vector(1 downto 0);
        WriteBack       : vl_logic_vector(1 downto 0)
    );
    port(
        step            : in     vl_logic_vector(1 downto 0);
        instruction     : in     vl_logic_vector(9 downto 0);
        InBus           : in     vl_logic_vector(8 downto 0);
        OutBus          : out    vl_logic_vector(8 downto 0);
        q               : out    vl_logic_vector(8 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NAME : constant is 5;
    attribute mti_svvh_generic_type of \FILE\ : constant is 5;
    attribute mti_svvh_generic_type of ReadMiss : constant is 6;
    attribute mti_svvh_generic_type of ReadHit : constant is 6;
    attribute mti_svvh_generic_type of WriteBack : constant is 6;
end cache;
