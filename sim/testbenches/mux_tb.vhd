library ieee;
use ieee.std_logic_1164.all;

entity mux_tb is
end entity;

architecture tb of mux_tb is
    signal e0, e1, s : std_logic_vector(15 downto 0);
    signal sel : std_logic;
begin
    UUT : entity work.Mux generic map(N => 16) port map(e_0 => e0, e_1 => e1, sel => sel, S => s);

    process
    begin
        e0 <= x"AAAA"; e1 <= x"5555";
        sel <= '0'; wait for 10 ns; assert s = x"AAAA" report "MUX sel 0 failed" severity error;
        sel <= '1'; wait for 10 ns; assert s = x"5555" report "MUX sel 1 failed" severity error;
        report "MUX test passed" severity note;
        wait;
    end process;
end architecture;
