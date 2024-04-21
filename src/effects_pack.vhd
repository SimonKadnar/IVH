-- autor: xkadna00

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package effects_pack is

type DIRECTION_T is (DIR_LEFT, DIR_RIGHT, DIR_TOP, ANIMATION);

function GETCOLUMN ( signal DATA : in std_logic_vector; COLID : in integer; ROWS : in integer) return std_logic_vector;
function NEAREST2N ( DATA : in natural ) return natural;

end effects_pack;

package body effects_pack is

	function GETCOLUMN ( signal DATA : in std_logic_vector; COLID : in integer; ROWS : in integer) return std_logic_vector is 
		variable value : std_logic_vector(0 to ROWS-1);
		variable COLUMNS : integer := (DATA'LENGTH/ROWS) -1;
 
		begin 
		
			if COLID > COLUMNS then 
				value := DATA (0 to ROWS-1);
			elsif COLID < 0 then 
				value := DATA (COLUMNS*ROWS to COLUMNS*ROWS + (ROWS-1) );
			else 
				value := DATA (COLID*ROWS to COLID*ROWS + (ROWS-1) );
			end if;
			
		return value;
	end;
	
	function NEAREST2N ( DATA : in natural ) return natural is
	variable value : natural := 1;
	
	
	begin
		while true loop
			if DATA <= value then 
				exit;
			end if;
			value:= value * 2;
		end loop;
		
		return value;
	end;
	
end effects_pack;
