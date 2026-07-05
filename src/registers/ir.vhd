library ieee;
use ieee.std_logic_1164.all;

entity IR is
    port(
        clk      : in  std_logic;
        raz      : in  std_logic;
        load     : in  std_logic;
        data_in  : in  std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(11 downto 0);
        opcode   : out std_logic_vector(3 downto 0)
    );
end entity IR;

architecture Arch of IR is
    signal ir_addr   : std_logic_vector(11 downto 0) := (others => '0');
    signal ir_opcode : std_logic_vector(3 downto 0)  := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if raz = '1' then
                ir_addr   <= (others => '0');
                ir_opcode <= (others => '0');
            elsif load = '1' then
                ir_opcode <= data_in(15 downto 12);
                ir_addr   <= data_in(11 downto 0);
            end if;
        end if;
    end process;

    data_out <= ir_addr;
    opcode   <= ir_opcode;
end architecture Arch;
