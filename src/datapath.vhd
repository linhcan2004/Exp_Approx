LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ExpApprox_pkg.ALL;

ENTITY datapath IS
    PORT (
        clk, reset : IN STD_LOGIC;
        t_in : IN SIGNED(15 DOWNTO 0);

        -- Cac vector 2-bit dieu khien bo mux 3:1
        x_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        y_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        z_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        i_sel : IN STD_LOGIC;   

	-- Cac chan cho phep nap
        en_regs : IN STD_LOGIC;
        en_out : IN STD_LOGIC;

	-- Cac tin hieu so sanh Z voi 0 va i voi 15
        z_eq : OUT STD_LOGIC; 
        i_eq : OUT STD_LOGIC;

	-- Tin hieu dau ra
        result : OUT SIGNED(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF datapath IS
    -- Khai bao cac tin hieu noi bo
    SIGNAL x, y, z : SIGNED(15 DOWNTO 0);
    SIGNAL i : INTEGER RANGE 0 TO 16;
    SIGNAL repeat : STD_LOGIC;
BEGIN

    PROCESS(clk, reset)
        VARIABLE x_shift, y_shift : SIGNED(15 DOWNTO 0);
    BEGIN
	-- Khi reset = 1, toan bo mach quay ve trang thai ban dau
        IF reset = '1' THEN
            x <= (OTHERS => '0'); 
	    y <= (OTHERS => '0'); 
	    z <= (OTHERS => '0');
            i <= 1; 
	    repeat <= '0'; 
	    result <= (OTHERS => '0');

        ELSIF rising_edge(clk) THEN
	    -- Khi co tin hieu enable thi moi cap nhat gia tri moi
            IF en_regs = '1' THEN
                x_shift := shift_right(x, i);
                y_shift := shift_right(y, i);

                -- Dieu khien thanh ghi X
                CASE x_sel IS
                    WHEN "11" => x <= K_INV;
                    WHEN "10" => x <= x + y_shift;
                    WHEN "01" => x <= x - y_shift;
                    WHEN OTHERS => NULL;
                END CASE;

                -- Dieu khien thanh ghi Y
                CASE y_sel IS
                    WHEN "11" => y <= (OTHERS => '0');
                    WHEN "10" => y <= y + x_shift;
                    WHEN "01" => y <= y - x_shift;
                    WHEN OTHERS => NULL;
                END CASE;

                -- Dieu khien thanh ghi Z
                CASE z_sel IS
                    WHEN "11" => z <= t_in;
                    WHEN "10" => z <= z - LUT(i-1);
                    WHEN "01" => z <= z + LUT(i-1);
                    WHEN OTHERS => NULL;
                END CASE;

                -- Dieu khien thanh ghi i
                IF i_sel = '1' THEN
                    i <= 1;
                ELSE
                    -- Can lap lai vong so 4 va 13 them mot lan nua
                    IF (i = 4 OR i = 13) AND repeat = '0' THEN
                        repeat <= '1';
                    ELSE
                        i <= i + 1; repeat <= '0';
                    END IF;
                END IF;
            END IF;

            IF en_out = '1' THEN
                result <= x + y;
            END IF;
        END IF;
    END PROCESS;

    z_eq <= '1' WHEN z >= 0 ELSE '0'; 
    i_eq <= '1' WHEN i <= N ELSE '0';

END ARCHITECTURE;
