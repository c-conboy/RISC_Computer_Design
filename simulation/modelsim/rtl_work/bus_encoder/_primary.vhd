library verilog;
use verilog.vl_types.all;
entity bus_encoder is
    port(
        Code            : out    vl_logic_vector(4 downto 0);
        Data            : in     vl_logic_vector(31 downto 0)
    );
end bus_encoder;
