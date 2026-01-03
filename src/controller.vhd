LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY controller IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

	-- Tin hieu bat dau va cac tin hieu so sanh z voi 0 va i voi 15
        start : IN STD_LOGIC;
        z_eq : IN STD_LOGIC;
        i_eq : IN STD_LOGIC;

        -- Cac chan dieu khien bo mux
        x_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        y_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        z_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        i_sel : OUT STD_LOGIC;

        -- Cac chan cho phep nap du lieu
        en_regs : OUT STD_LOGIC;
        en_out : OUT STD_LOGIC;

	-- Tin hieu thong bao da hoan thanh
        c_done : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF controller IS
    -- Dinh nghia cac trang thai cua he thong may fsm
    TYPE state_type IS (IDLE, SETUP, CALC, DONE);
    SIGNAL current_state, next_state : state_type;
BEGIN

    -- Bo chuyen trang thai dong bo theo xung clock
    PROCESS(clk, reset) BEGIN
        IF reset = '1' THEN
            current_state <= IDLE;
        ELSIF rising_edge(clk) THEN
            current_state <= next_state;
        END IF;
    END PROCESS;

    -- Logic chuyen trang thai va tinh toan dau ra
    PROCESS(current_state, start, z_eq, i_eq) BEGIN

	-- Khoi tao gia tri mac dinh
        next_state <= current_state;
        x_sel <= "00"; 
	y_sel <= "00"; 
	z_sel <= "00"; 
	i_sel <= '0';
        en_regs <= '0'; 
	en_out <= '0'; 
	c_done <= '0';

	-- Xet 4 truong hop trang thai hien tai va tim trang thai ke tiep
        CASE current_state IS

	    -- Cho tin hieu start len 1
            WHEN IDLE =>
                IF start = '1' THEN
                    next_state <= SETUP;
                END IF;

	    -- Bat dau khoi tao cac gia tri dau vao
            WHEN SETUP =>
                x_sel <= "11"; 
		y_sel <= "11"; 
		z_sel <= "11"; 
		i_sel <= '1';
                en_regs <= '1';
                next_state <= CALC;

	    -- Mach thuc hien cac phep dich bit va cong tru lien tuc 17 lan
            WHEN CALC =>
                IF i_eq = '1' THEN
                    en_regs <= '1';
                    i_sel <= '0';

                    IF z_eq = '1' THEN
                        x_sel <= "10"; y_sel <= "10"; z_sel <= "10";
                    ELSE
                        x_sel <= "01"; y_sel <= "01"; z_sel <= "01";
                    END IF;
                    next_state <= CALC;
                ELSE
                    next_state <= DONE;
                END IF;

            WHEN DONE =>
                en_out <= '1';
                c_done <= '1';
                IF start = '0' THEN
                    next_state <= IDLE;
                END IF;
        END CASE;
    END PROCESS;

END ARCHITECTURE;
