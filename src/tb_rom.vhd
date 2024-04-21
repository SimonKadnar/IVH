--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:19:26 05/08/2023
-- Design Name:   
-- Module Name:   /mnt/e/Users/LENOVO/Desktop/6.Semester/ivh/aaaaaaaaa/tb_rom.vhd
-- Project Name:  proj
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: rom
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_rom IS
END tb_rom;
 
ARCHITECTURE behavior OF tb_rom IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rom
    PORT(
         address : IN  std_logic_vector(3 downto 0);
         data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

	signal clk : std_logic := '0'; 

   --Inputs
   signal address : std_logic_vector(3 downto 0) := "0001";

 	--Outputs
   signal data : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_per : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rom PORT MAP (
          address => address,
          data => data
        );

   -- Clock process definitions
   clock :process
   begin
		clk <= '0';
		wait for clk_per/2;
		clk <= '1';
		wait for clk_per/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 10 ns;
			
		address <= "0000";
		for i in 0 to 15 loop
			wait for 1 ns;
			address <= address +1;

		end loop;
      
      wait for clk_per*10;

      -- insert stimulus here 

      wait;
   end process;

END;
