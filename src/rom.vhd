library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity rom is
port(
	address: in std_logic_vector(3 downto 0);
	data: out std_logic_vector(7 downto 0)
);
end entity;

architecture Behavioral of rom is
	type rom_array is array (0 to 15) of std_logic_vector(7 downto 0);
	constant rom: rom_array := ("00000000","00000000","00000000","00011000",
										 "10011100","01010110","10111111","01011111",
										 "01011111","10111111","01010110","10011100",
										 "00011000","00000000","00000000","00000000");
										 
begin
	data <= rom(conv_integer(address));
end architecture;