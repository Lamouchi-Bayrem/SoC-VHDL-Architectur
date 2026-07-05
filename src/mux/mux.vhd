library ieee;
use ieee.std_logic_1164.all;

entity Mux is
    generic(
        N : integer := 16
    );
    port(
        e_0 : in  std_logic_vector((N-1) downto 0);
        e_1 : in  std_logic_vector((N-1) downto 0);
        sel : in  std_logic;
        S   : out std_logic_vector((N-1) downto 0)
    );
end entity Mux;

architecture arch of Mux is
begin
    S <= e_0 when sel = '0' else e_1;
end architecture arch;
