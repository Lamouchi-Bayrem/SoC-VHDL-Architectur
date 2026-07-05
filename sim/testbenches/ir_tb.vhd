library ieee;
use ieee.std_logic_1164.all;

entity ir_tb is
end entity;

architecture tb of ir_tb is
    signal clk, load, raz : std_logic := '0';
    signal data_in : std_logic_vector(15 downto 0);
    signal data_out : std_logic_vector(11 downto 0);
    signal opcode : std_logic_vector(3 downto 0);
begin
    UUT : entity work.IR port map(clk => clk, raz => raz, load => load, data_in => data_in, data_out => data_out, opcode => opcode);
    clk <= not clk after 5 ns;

    process
    begin
        raz <= '1'; wait for 12 ns; raz <= '0';
        data_in <= x"2011"; load <= '1'; wait for 10 ns; load <= '0';
        assert opcode = "0010" report "IR opcode failed" severity error;
        assert data_out = x"011" report "IR address failed" severity error;
        report "IR test passed" severity note;
        wait;
    end process;
end architecture;
