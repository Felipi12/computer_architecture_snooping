library verilog;
use verilog.vl_types.all;
entity memory is
    generic(
        \FILE\          : vl_notype;
        ReadMiss        : vl_logic_vector(1 downto 0);
        WriteBack       : vl_logic_vector(1 downto 0)
    );
    port(
        \bus\           : in     vl_logic_vector(8 downto 0);
        q               : out    vl_logic_vector(8 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of \FILE\ : constant is 5;
    attribute mti_svvh_generic_type of ReadMiss : constant is 6;
    attribute mti_svvh_generic_type of WriteBack : constant is 6;
end memory;
