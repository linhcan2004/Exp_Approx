LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ExpApprox IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        done : OUT STD_LOGIC;
        
        -- Nut bam de xem trang sau
        btn_page : IN STD_LOGIC; 
        
        -- 8 switch dung de nhap du lieu
        sw : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        
        -- 8 LED dung de hien thi ca 16-bit ket qua
        led : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE str OF ExpApprox IS
    -- Cac tin hieu noi day ben trong
    SIGNAL s_x_sel, s_y_sel, s_z_sel : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL s_i_sel, s_en_regs, s_en_out : STD_LOGIC;
    SIGNAL s_z_eq, s_i_eq, s_done : STD_LOGIC;

    -- Tin hieu 16-bit day du
    SIGNAL t_in : SIGNED(15 DOWNTO 0);
    SIGNAL result : SIGNED(15 DOWNTO 0);

BEGIN
    -- Dung 8 switch de nhap vao 8-bit cao nhat
    -- 8-bit thap tu dong duoc gan bang 0
    t_in <= SIGNED(sw) & "00000000";

    -- Ket noi Controller
    U_CONTROLLER : ENTITY work.controller
        PORT MAP (
            clk => clk,
            reset => reset,
            start => start,
            z_eq => s_z_eq,
            i_eq => s_i_eq,
            x_sel => s_x_sel,
            y_sel => s_y_sel,
            z_sel => s_z_sel,
            i_sel => s_i_sel,
            en_regs => s_en_regs,
            en_out => s_en_out,
            c_done => s_done
        );

    -- Ket noi Datapath
    U_DATAPATH : ENTITY work.datapath
        PORT MAP (
            clk => clk,
            reset => reset,
            t_in => t_in,
            x_sel => s_x_sel,
            y_sel => s_y_sel,
            z_sel => s_z_sel,
            i_sel => s_i_sel,
            en_regs => s_en_regs,
            en_out => s_en_out,
            z_eq => s_z_eq,
            i_eq => s_i_eq,
            result => result
        );
    -- Logic: Binh thuong LED se hien 8-bit cao.
    -- Khi giu nut "btn_page", LED se chuyen sang hien 8-bit thap.
    PROCESS(btn_page, result)
    BEGIN
        IF btn_page = '1' THEN
            -- 8-bit thap
            led <= STD_LOGIC_VECTOR(result(7 DOWNTO 0));
        ELSE
            -- 8-bit cao
            led <= STD_LOGIC_VECTOR(result(15 DOWNTO 8));
        END IF;
    END PROCESS;
    
    done <= s_done;

END ARCHITECTURE;