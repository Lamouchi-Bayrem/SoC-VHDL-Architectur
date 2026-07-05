library ieee;
use ieee.std_logic_1164.all;

entity p3e_tb is
end entity;

architecture tb of p3e_tb is
    signal oe : std_logic;
    signal data_in, data_out : std_logic_vector(15 downto 0);
begin
    UUT : entity work.P3E port map(oe => oe, data_in => data_in, data_out => data_out);

    process
    begin
        data_in <= x"1234";
        oe <= '1'; wait for 10 ns; assert data_out = x"1234" report "P3E enable failed" severity error;
        oe <= '0'; wait for 10 ns; assert data_out = (data_out'range => 'Z') report "P3E high-Z failed" severity error;
        report "P3E test passed" severity note;
        wait;
    end process;
end architecture;
