library ieee;
use ieee.std_logic_1164.all;

entity Acc is
    port(
        clk      : in  std_logic;
        load     : in  std_logic;
        raz      : in  std_logic;
        data_in  : in  std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0);
        accz     : out std_logic;
        acc15    : out std_logic
    );
end entity Acc;

architecture Arch of Acc is
    signal Sinter : std_logic_vector(15 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if raz = '1' then
                Sinter <= (others => '0');
            elsif load = '1' then
                Sinter <= data_in;
            end if;
        end if;
    end process;

    accz     <= '1' when Sinter = x"0000" else '0';
    acc15    <= Sinter(15);
    data_out <= Sinter;
end architecture Arch;
