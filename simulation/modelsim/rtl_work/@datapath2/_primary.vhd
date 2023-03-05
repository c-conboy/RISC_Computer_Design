library verilog;
use verilog.vl_types.all;
entity Datapath2 is
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        HIin            : in     vl_logic;
        HIout           : in     vl_logic;
        LOin            : in     vl_logic;
        LOout           : in     vl_logic;
        PCin            : in     vl_logic;
        PCout           : in     vl_logic;
        IRin            : in     vl_logic;
        Zin             : in     vl_logic;
        Zhighout        : in     vl_logic;
        Zlowout         : in     vl_logic;
        Yin             : in     vl_logic;
        MARin           : in     vl_logic;
        MDRin           : in     vl_logic;
        MDRout          : in     vl_logic;
        Read            : in     vl_logic;
        Write           : in     vl_logic;
        Cout            : in     vl_logic;
        MBIout          : in     vl_logic;
        manualBusInput  : in     vl_logic_vector(31 downto 0);
        OpCode          : in     vl_logic_vector(4 downto 0);
        Gra             : in     vl_logic;
        Grb             : in     vl_logic;
        Grc             : in     vl_logic;
        Rin             : in     vl_logic;
        Rout            : in     vl_logic;
        BAout           : in     vl_logic;
        CONin           : in     vl_logic;
        OutportIn       : in     vl_logic
    );
end Datapath2;
