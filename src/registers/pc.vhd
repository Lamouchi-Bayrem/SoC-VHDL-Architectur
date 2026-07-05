library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(
        clk      : in  std_logic;
        raz      : in  std_logic;
        load     : in  std_logic;
        data_in  : in  std_logic_vector(11 downto 0);
        data_out : out std_logic_vector(11 downto 0)
    );
end entity PC;

architecture arch of PC is
    signal pc_reg : std_logic_vector(11 downto 0) := (others => '0');
begin
    process(clk, raz)
    begin
        if raz = '1' then
            pc_reg <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                pc_reg <= std_logic_vector(unsigned(data_in) + 1);
            end if;
        end if;
    end process;

    data_out <= pc_reg;
end architecture arch;
