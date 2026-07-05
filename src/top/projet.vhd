library ieee;
use ieee.std_logic_1164.all;

entity Projet is
    port(
        clk      : in    std_logic;
        reset    : in    std_logic;
        data_bus : inout std_logic_vector(15 downto 0);
        addr_bus : inout std_logic_vector(11 downto 0)
    );
end entity Projet;

architecture arch of Projet is
    signal S_MEMRQ : std_logic;
    signal S_RNW   : std_logic;
begin
    B1 : entity work.mu
        port map(
            clk      => clk,
            reset    => reset,
            addr_bus => addr_bus,
            data_bus => data_bus,
            memrq    => S_MEMRQ,
            rnw      => S_RNW
        );

    B2 : entity work.mem
        port map(
            clk      => clk,
            MEMrq    => S_MEMRQ,
            RnW      => S_RNW,
            addr_bus => addr_bus,
            data_bus => data_bus
        );
end architecture arch;
