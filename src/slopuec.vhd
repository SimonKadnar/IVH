-- autor: xkadna00

library ieee;
use ieee.std_logic_1164.all;
use work.effects_pack.all;

entity column is
  generic (
    N : natural := 8 
  );
  port (
    CLK : in std_logic;          
    RESET : in std_logic;        
    STATE : out std_logic_vector(N-1 downto 0);  
    INIT_STATE : in std_logic_vector(N-1 downto 0);  
    NEIGH_LEFT : in std_logic_vector(N-1 downto 0); 
    NEIGH_RIGHT : in std_logic_vector(N-1 downto 0); 
    DIRECTION : in DIRECTION_T;  
    EN : in std_logic            
  );
end entity column;

architecture behavioral of column is

  signal result : std_logic_vector(N-1 downto 0);
begin

  process (CLK, RESET)
  begin
    if rising_edge(CLK) then
      if RESET = '1' then
        result <= INIT_STATE;
		  
      else
			if EN = '1' then
		
        case DIRECTION is
          when DIR_LEFT =>
				result <= NEIGH_RIGHT;
				
          when DIR_RIGHT =>
				result <= NEIGH_LEFT;
			
          when DIR_TOP =>
            for i in 0 to N-1 loop
					if i = n-1 then
						result(i) <= '0';
					else 
						result(i) <= result(i+1);
					end if;
            end loop;
							
			when ANIMATION =>
				for i in 0 to N-1 loop
					if i > N-4 then
						result(i) <= NEIGH_LEFT(i);
					else 
						if i > N-6 then
						result(i) <= NEIGH_RIGHT(i);
						else 
						result(i) <= NEIGH_LEFT(i);
						end if;
					end if;
				end loop;
															
			end case;
		  end if;
      end if;
    end if;
  end process;

  STATE <= result;
end architecture behavioral;