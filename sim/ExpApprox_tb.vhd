LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ExpApprox_tb IS
END ENTITY;

ARCHITECTURE BEV OF ExpApprox_tb IS

    -- Khai bao tin hieu
    SIGNAL clk      : STD_LOGIC := '0';
    SIGNAL reset    : STD_LOGIC := '0';
    SIGNAL start    : STD_LOGIC := '0';
    SIGNAL btn_page : STD_LOGIC := '0';
    SIGNAL sw       : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL led      : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL done     : STD_LOGIC; 

BEGIN

    -- Goi khoi ExpApprox
    UUT : ENTITY work.ExpApprox
        PORT MAP (
            clk => clk,
            reset => reset,
            start => start,
            btn_page => btn_page,
            sw => sw,
            done => done,
            led => led
        );

    -- Tao xung clock
    clk_process : PROCESS BEGIN
        clk <= '0'; WAIT FOR 5 ns;
        clk <= '1'; WAIT FOR 5 ns;
    END PROCESS;

    -- Kich ban kiem tra
    stim_proc: PROCESS 
    BEGIN
        reset <= '1'; WAIT FOR 50 ns;
        reset <= '0'; WAIT FOR 20 ns;

        -- Truong hop 1: t = 0
        sw <= x"00"; 
        start <= '1'; 
        WAIT FOR 20 ns; 
        start <= '0';
        
        WAIT UNTIL done = '1'; 

        WAIT FOR 20 ns;
        btn_page <= '1'; 
        WAIT FOR 50 ns; 
        btn_page <= '0';

        WAIT FOR 50 ns;

        -- Truong hop 2: t = 0.5
        sw <= x"20"; 
        start <= '1'; 
        WAIT FOR 20 ns; 
        start <= '0';
        
        WAIT UNTIL done = '1';
        
        WAIT FOR 20 ns;
        btn_page <= '1'; 
        WAIT FOR 50 ns; 
        btn_page <= '0';

        -- Truong hop 3: t = -1.0
        sw <= x"C0";
        start <= '1'; 
        WAIT FOR 20 ns; 
        start <= '0';
        
        WAIT UNTIL done = '1';
        
        WAIT FOR 20 ns;
        btn_page <= '1'; 
        WAIT FOR 50 ns; 
        btn_page <= '0';

        WAIT;
    END PROCESS;

END ARCHITECTURE;