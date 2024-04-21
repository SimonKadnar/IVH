-- autor: xkadna00

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.effects_pack.all;

architecture Behavioral of tlv_gp_ifc is
	signal cnt : std_logic_vector(23 downto 0) := (others => '0');  -- 1s - 25MHz / 20M ~ 24b
	signal A : std_logic_vector(3 downto 0);
	signal R : std_logic_vector(7 downto 0);
	
begin
	fsm: entity work.fsm(behavioral)
	port map(
		CLK => CLK,
		RESET => RESET,
		A => A,
		R => R
	);
	
    -- mapovani vystupu
    -- nemenit
	 
    X(6) <= A(3);
    X(8) <= A(1);
    X(10) <= A(0);
    X(7) <= '0'; -- en_n
    X(9) <= A(2);

    X(16) <= R(1);
    X(18) <= R(0);
    X(20) <= R(7);
    X(22) <= R(2);
  
    X(17) <= R(4);
    X(19) <= R(3);
    X(21) <= R(6);
    X(23) <= R(5);
end Behavioral;