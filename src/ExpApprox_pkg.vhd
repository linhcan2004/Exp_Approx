LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE ExpApprox_pkg IS
    -- Chon 15 vong lap de co ket qua chinh xac nhat co the
    CONSTANT N : integer := 15;

    -- De tinh he so K, ta can lap them mot lan nua tai i = 4 va i = 13 de dam bao dieu kien hoi tu
    -- Sau khi tinh duoc K = 0.8281, ta tinh he so bu 1/K = 1.2075
    -- Theo dinh dang Q2.14: 1.2075 * 2^14 = 19784, chuyen sang he HEX la 4D48
    CONSTANT K_INV : signed(15 downto 0) := x"4D48"; 

    -- Dinh nghia mot kieu danh sach de chua 15 gia tri trong bang LUT
    TYPE lut_table IS ARRAY (0 to 14) OF SIGNED (15 downto 0);

    -- Bang tra cuu LUT chua cac gia tri atanh(2^-i) da duoc tinh san
    -- Tat ca cac gia tri tren deu duoc nhan voi 2^14 de thanh so nguyen 16-bit
    CONSTANT LUT : lut_table := (
        x"2328", -- i=1
        x"1058", -- i=2
        x"080A", -- i=3
        x"0401", -- i=4
        x"0200", -- i=5
        x"0100", -- i=6
        x"0080", -- i=7
        x"0040", -- i=8
        x"0020", -- i=9
        x"0010", -- i=10
        x"0008", -- i=11
        x"0004", -- i=12
        x"0002", -- i=13
        x"0001", -- i=14
        x"0000"  -- i=15
    );
END PACKAGE;
