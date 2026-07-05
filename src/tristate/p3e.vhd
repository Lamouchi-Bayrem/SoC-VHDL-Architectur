library ieee;
use ieee.std_logic_1164.all;

entity P3E is
    port(
        oe       : in  std_logic;
        data_in  : in  std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
    );
end entity P3E;

architecture arch of P3E is
begin
    data_out <= data_in when oe = '1' else (others => 'Z');
end architecture arch;
