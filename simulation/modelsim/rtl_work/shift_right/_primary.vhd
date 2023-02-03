library verilog;
use verilog.vl_types.all;
entity shift_right is
    port(
        C               : out    vl_logic_vector(31 downto 0);
        A               : in     vl_logic_vector(31 downto 0)
    );
end shift_right;
