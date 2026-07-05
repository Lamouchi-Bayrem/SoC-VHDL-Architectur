library ieee;
use ieee.std_logic_1164.all;

entity pc_tb is
end entity;

architecture tb of pc_tb is
    signal clk, load, raz : std_logic := '0';
    signal data_in, data_out : std_logic_vector(11 downto 0);
begin
    UUT : entity work.PC port map(clk => clk, raz => raz, load => load, data_in => data_in, data_out => data_out);
    clk <= not clk after 5 ns;

    process
    begin
        raz <= '1'; wait for 12 ns; raz <= '0';
        data_in <= x"010"; load <= '1'; wait for 10 ns; load <= '0';
        assert data_out = x"011" report "PC load/increment failed" severity error;
        report "PC test passed" severity note;
        wait;
    end process;
end architecture;
