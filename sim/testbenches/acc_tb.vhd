library ieee;
use ieee.std_logic_1164.all;

entity acc_tb is
end entity;

architecture tb of acc_tb is
    signal clk, load, raz, accz, acc15 : std_logic := '0';
    signal data_in, data_out : std_logic_vector(15 downto 0);
begin
    UUT : entity work.Acc port map(clk => clk, load => load, raz => raz, data_in => data_in, data_out => data_out, accz => accz, acc15 => acc15);
    clk <= not clk after 5 ns;

    process
    begin
        raz <= '1'; wait for 12 ns; raz <= '0';
        data_in <= x"8001"; load <= '1'; wait for 10 ns; load <= '0';
        assert data_out = x"8001" report "ACC load failed" severity error;
        assert acc15 = '1' report "ACC sign flag failed" severity error;
        report "ACC test passed" severity note;
        wait;
    end process;
end architecture;
