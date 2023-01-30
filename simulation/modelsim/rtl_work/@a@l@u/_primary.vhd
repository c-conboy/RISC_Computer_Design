library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        A               : in     vl_logic_vector(0 to 31);
        B               : in     vl_logic_vector(0 to 31);
        op              : in     vl_logic_vector(4 downto 0);
        result          : out    vl_logic_vector(0 to 31)
    );
end ALU;
