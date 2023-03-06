library verilog;
use verilog.vl_types.all;
entity CONFF is
    port(
        C2              : in     vl_logic_vector(1 downto 0);
        BusMuxOut       : in     vl_logic_vector(31 downto 0);
        ConRegInput     : out    vl_logic_vector(31 downto 0)
    );
end CONFF;
