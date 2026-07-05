library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end entity;

architecture tb of alu_tb is
    signal A, B, S : std_logic_vector(15 downto 0);
    signal alufs  : std_logic_vector(3 downto 0);
begin
    UUT : entity work.ALU port map(A => A, B => B, alufs => alufs, S => S);

    process
    begin
        A <= x"0005"; B <= x"0003";
        alufs <= "0000"; wait for 10 ns; assert S = x"0003" report "ALU B failed" severity error;
        alufs <= "0001"; wait for 10 ns; assert S = x"0004" report "ALU B+1 failed" severity error;
        alufs <= "0010"; wait for 10 ns; assert S = x"0008" report "ALU ADD failed" severity error;
        alufs <= "0011"; wait for 10 ns; assert S = x"0002" report "ALU SUB failed" severity error;
        alufs <= "1000"; wait for 10 ns; assert S = x"0001" report "ALU AND failed" severity error;
        alufs <= "1001"; wait for 10 ns; assert S = x"0007" report "ALU OR failed" severity error;
        alufs <= "1010"; wait for 10 ns; assert S = x"0006" report "ALU XOR failed" severity error;
        report "ALU test passed" severity note;
        wait;
    end process;
end architecture;
