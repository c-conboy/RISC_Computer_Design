library verilog;
use verilog.vl_types.all;
entity and_or is
    port(
        A               : in     vl_logic_vector(0 to 31);
        B               : in     vl_logic_vector(0 to 31);
        selection       : in     vl_logic;
        result          : out    vl_logic_vector(0 to 31)
    );
end and_or;
