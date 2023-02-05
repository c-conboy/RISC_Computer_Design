library verilog;
use verilog.vl_types.all;
entity shra is
    port(
        C               : out    vl_logic_vector(31 downto 0);
        A               : in     vl_logic_vector(31 downto 0)
    );
end shra;
