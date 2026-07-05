library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
    port(
        clk      : in    std_logic;
        MEMrq    : in    std_logic;
        RnW      : in    std_logic;
        addr_bus : in    std_logic_vector(11 downto 0);
        data_bus : inout std_logic_vector(15 downto 0)
    );
end entity mem;

architecture arch of mem is
    type ram_type is array (0 to 4095) of std_logic_vector(15 downto 0);

    -- Demo program:
    -- 0: LDA 0x010
    -- 1: ADD 0x011
    -- 2: STO 0x012
    -- 3: STOP
    -- 0x010: 5
    -- 0x011: 3
    signal ram : ram_type := (
        0      => x"0010",
        1      => x"2011",
        2      => x"1012",
        3      => x"7000",
        16     => x"0005",
        17     => x"0003",
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if MEMrq = '1' and RnW = '0' then
                ram(to_integer(unsigned(addr_bus))) <= data_bus;
            end if;
        end if;
    end process;

    data_bus <= ram(to_integer(unsigned(addr_bus))) when MEMrq = '1' and RnW = '1' else (others => 'Z');
end architecture arch;
