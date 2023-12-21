library verilog;
use verilog.vl_types.all;
entity RAM is
    port(
        ReadS           : in     vl_logic;
        WriteS          : in     vl_logic;
        address         : in     vl_logic_vector(8 downto 0);
        Data            : inout  vl_logic_vector(31 downto 0)
    );
end RAM;
