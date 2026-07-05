library ieee;
use ieee.std_logic_1164.all;

entity bench_projet is
end entity bench_projet;

architecture Arch of bench_projet is
    signal clk_b      : std_logic := '0';
    signal reset_b    : std_logic := '1';
    signal data_bus_b : std_logic_vector(15 downto 0);
    signal addr_bus_b : std_logic_vector(11 downto 0);
begin
    U : entity work.Projet
        port map(
            clk      => clk_b,
            reset    => reset_b,
            data_bus => data_bus_b,
            addr_bus => addr_bus_b
        );

    clk_b <= not clk_b after 50 ns;

    process
    begin
        reset_b <= '1';
        wait for 120 ns;
        reset_b <= '0';
        wait for 2000 ns;
        report "Full project simulation finished" severity note;
        wait;
    end process;
end architecture Arch;
