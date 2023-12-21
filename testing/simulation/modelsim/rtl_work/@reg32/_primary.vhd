library verilog;
use verilog.vl_types.all;
entity Reg32 is
    port(
        D               : in     vl_logic_vector(31 downto 0);
        Q               : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        e               : in     vl_logic
    );
end Reg32;
