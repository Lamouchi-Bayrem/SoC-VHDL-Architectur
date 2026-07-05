library ieee;
use ieee.std_logic_1164.all;

entity sequenceurSOC is
    port(
        clk, reset       : in  std_logic;
        accz, acc15      : in  std_logic;
        opcode           : in  std_logic_vector(3 downto 0);
        raz              : out std_logic;
        selA             : out std_logic;
        selB             : out std_logic;
        acc_ld, pc_ld    : out std_logic;
        ir_ld, acc_oe    : out std_logic;
        alufs            : out std_logic_vector(3 downto 0);
        memrq, rnw       : out std_logic
    );
end entity sequenceurSOC;

architecture arch_seq of sequenceurSOC is
    type etat is (INIT, FETCH, EXECUTE, STOP);
    signal etat_present, etat_futur : etat := INIT;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            etat_present <= INIT;
            raz <= '1';
        elsif rising_edge(clk) then
            etat_present <= etat_futur;
            raz <= '0';
        end if;
    end process;

    process(etat_present, opcode, accz, acc15)
    begin
        -- Default values to avoid latch inference
        etat_futur <= etat_present;
        selA   <= '0';
        selB   <= '0';
        acc_ld <= '0';
        pc_ld  <= '0';
        ir_ld  <= '0';
        acc_oe <= '0';
        alufs  <= "0000";
        memrq  <= '1';
        rnw    <= '1';

        case etat_present is
            when INIT =>
                etat_futur <= FETCH;

            when FETCH =>
                ir_ld <= '1';       -- Load instruction register from data bus
                pc_ld <= '1';       -- PC <= PC + 1
                alufs <= "0000";    -- ALU transfers B
                selA  <= '0';       -- Address bus from PC
                selB  <= '0';       -- ALU B from zero-extended address bus
                rnw   <= '1';       -- Memory read
                etat_futur <= EXECUTE;

            when EXECUTE =>
                case opcode is
                    when "0000" =>   -- LDA
                        selA   <= '1';
                        selB   <= '1';
                        alufs  <= "0000";
                        acc_ld <= '1';
                        etat_futur <= FETCH;

                    when "0001" =>   -- STO
                        selA   <= '1';
                        acc_oe <= '1';
                        rnw    <= '0';
                        etat_futur <= FETCH;

                    when "0010" =>   -- ADD
                        selA   <= '1';
                        selB   <= '1';
                        alufs  <= "0010";
                        acc_ld <= '1';
                        etat_futur <= FETCH;

                    when "0011" =>   -- SUB
                        selA   <= '1';
                        selB   <= '1';
                        alufs  <= "0011";
                        acc_ld <= '1';
                        etat_futur <= FETCH;

                    when "0100" =>   -- JMP
                        selA  <= '1';
                        alufs <= "0000";
                        pc_ld <= '1';
                        etat_futur <= FETCH;

                    when "0101" =>   -- JGE
                        if acc15 = '0' then
                            selA  <= '1';
                            alufs <= "0000";
                            pc_ld <= '1';
                        end if;
                        etat_futur <= FETCH;

                    when "0110" =>   -- JNE
                        if accz = '0' then
                            selA  <= '1';
                            alufs <= "0000";
                            pc_ld <= '1';
                        end if;
                        etat_futur <= FETCH;

                    when "0111" =>   -- STOP
                        etat_futur <= STOP;

                    when "1000" =>   -- AND
                        selA   <= '1';
                        selB   <= '1';
                        alufs  <= "1000";
                        acc_ld <= '1';
                        etat_futur <= FETCH;

                    when "1001" =>   -- OR
                        selA   <= '1';
                        selB   <= '1';
                        alufs  <= "1001";
                        acc_ld <= '1';
                        etat_futur <= FETCH;

                    when "1010" =>   -- XOR
                        selA   <= '1';
                        selB   <= '1';
                        alufs  <= "1010";
                        acc_ld <= '1';
                        etat_futur <= FETCH;

                    when others =>
                        etat_futur <= STOP;
                end case;

            when STOP =>
                memrq <= '0';
                rnw   <= '1';
                etat_futur <= STOP;
        end case;
    end process;
end architecture arch_seq;
