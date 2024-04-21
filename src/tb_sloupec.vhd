--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:58:05 05/08/2023
-- Design Name:   
-- Module Name:   /mnt/e/Users/LENOVO/Desktop/6.Semester/ivh/aaaaaaaaa/tb_sloupec.vhd
-- Project Name:  proj
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: column
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.effects_pack.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_sloupec IS
END tb_sloupec;
 
ARCHITECTURE behavior OF tb_sloupec IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT column
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         STATE : OUT  std_logic_vector(7 downto 0);
         INIT_STATE : IN  std_logic_vector(7 downto 0);
         NEIGH_LEFT : IN  std_logic_vector(7 downto 0);
         NEIGH_RIGHT : IN  std_logic_vector(7 downto 0);
         DIRECTION : IN  DIRECTION_T;
         EN : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal INIT_STATE : std_logic_vector(7 downto 0) := (others => '0');
   signal NEIGH_LEFT : std_logic_vector(7 downto 0) := (others => '0');
   signal NEIGH_RIGHT : std_logic_vector(7 downto 0) := (others => '0');
   signal DIRECTION : DIRECTION_T := DIR_RIGHT;
   signal EN : std_logic := '0';

 	--Outputs
   signal STATE : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: column PORT MAP (
          CLK => CLK,
          RESET => RESET,
          STATE => STATE,
          INIT_STATE => INIT_STATE,
          NEIGH_LEFT => NEIGH_LEFT,
          NEIGH_RIGHT => NEIGH_RIGHT,
          DIRECTION => DIRECTION,
          EN => EN
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		INIT_STATE <= "11000011";
		NEIGH_LEFT <= "00111100";
		NEIGH_RIGHT <= "01011010";
		
		EN <= '0';
		RESET <= '1';
      wait for 10 ns;	
		RESET <= '0';
		EN <= '1';

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
