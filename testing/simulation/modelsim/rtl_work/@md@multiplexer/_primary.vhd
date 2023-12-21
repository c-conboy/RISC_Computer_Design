library verilog;
use verilog.vl_types.all;
entity MdMultiplexer is
    port(
        BusMuxOut       : in     vl_logic_vector(31 downto 0);
        Mdatain         : in     vl_logic_vector(31 downto 0);
        Read            : in     vl_logic;
        MdMuxOutput     : out    vl_logic_vector(31 downto 0)
    );
end MdMultiplexer;
