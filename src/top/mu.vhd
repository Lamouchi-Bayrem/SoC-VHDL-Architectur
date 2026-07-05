library ieee;
use ieee.std_logic_1164.all;

entity mu is
    port(
        clk, reset : in    std_logic;
        addr_bus   : inout std_logic_vector(11 downto 0);
        data_bus   : inout std_logic_vector(15 downto 0);
        memrq      : out   std_logic;
        rnw        : out   std_logic
    );
end entity mu;

architecture Arch of mu is
    signal Sopcode  : std_logic_vector(3 downto 0);
    signal Sraz     : std_logic;
    signal ir_out   : std_logic_vector(11 downto 0);
    signal pc_out   : std_logic_vector(11 downto 0);
    signal alu_out  : std_logic_vector(15 downto 0);
    signal acc_out  : std_logic_vector(15 downto 0);
    signal muxb_out : std_logic_vector(15 downto 0);
    signal Sconcat  : std_logic_vector(15 downto 0);
    signal Salufs   : std_logic_vector(3 downto 0);
    signal Sir_ld   : std_logic;
    signal Spc_ld   : std_logic;
    signal Sacc_ld  : std_logic;
    signal Sacc_oe  : std_logic;
    signal SselA    : std_logic;
    signal SselB    : std_logic;
    signal Saccz    : std_logic;
    signal Sacc15   : std_logic;
begin
    B_P3E : entity work.P3E
        port map(
            oe       => Sacc_oe,
            data_in  => acc_out,
            data_out => data_bus
        );

    B_MuxA : entity work.Mux
        generic map(N => 12)
        port map(
            e_0 => pc_out,
            e_1 => ir_out,
            sel => SselA,
            S   => addr_bus
        );

    B_MuxB : entity work.Mux
        generic map(N => 16)
        port map(
            e_0 => Sconcat,
            e_1 => data_bus,
            sel => SselB,
            S   => muxb_out
        );

    B_ALU : entity work.ALU
        port map(
            A     => acc_out,
            B     => muxb_out,
            alufs => Salufs,
            S     => alu_out
        );

    B_Acc : entity work.Acc
        port map(
            clk      => clk,
            load     => Sacc_ld,
            raz      => Sraz,
            data_in  => alu_out,
            data_out => acc_out,
            accz     => Saccz,
            acc15    => Sacc15
        );

    B_PC : entity work.PC
        port map(
            clk      => clk,
            raz      => Sraz,
            load     => Spc_ld,
            data_in  => alu_out(11 downto 0),
            data_out => pc_out
        );

    B_IR : entity work.IR
        port map(
            clk      => clk,
            raz      => Sraz,
            load     => Sir_ld,
            data_in  => data_bus,
            data_out => ir_out,
            opcode   => Sopcode
        );

    Sconcat <= "0000" & addr_bus;

    U_sequenceur : entity work.sequenceurSOC
        port map(
            clk    => clk,
            reset  => reset,
            accz   => Saccz,
            acc15  => Sacc15,
            opcode => Sopcode,
            raz    => Sraz,
            selA   => SselA,
            selB   => SselB,
            acc_ld => Sacc_ld,
            pc_ld  => Spc_ld,
            ir_ld  => Sir_ld,
            acc_oe => Sacc_oe,
            alufs  => Salufs,
            memrq  => memrq,
            rnw    => rnw
        );
end architecture Arch;
