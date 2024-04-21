-- autor: xkadna00

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.effects_pack.all;
library work;

entity fsm is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  signal A : out std_logic_vector(3 downto 0);
			  signal R : out std_logic_vector(7 downto 0)
			  );
end fsm;

architecture Behavioral of fsm is

	signal RESET_STLPEC : std_logic := '0';
	type STATE_T is (st1_load, st2_right, st3_left, st4_top, st5_animation);
	signal FSM_STATE : STATE_T := st1_load;
	
	signal loaded : std_logic := '0';
	signal load : std_logic := '0';
	signal rotation_ended : std_logic_vector(1 downto 0) := "00";
	signal rotation_start : std_logic := '0';
	
	signal DIRECTION : DIRECTION_T := DIR_RIGHT;
	signal EN : std_logic := '0';
	
	type state_array is array (0 to 15) of std_logic_vector(7 downto 0);
	signal STATE : state_array;
	signal DATA_ALL: state_array;
	signal address : std_logic_vector(3 downto 0) := "0001";
	signal A_adress : std_logic_vector(3 downto 0) := "0001";
	signal data: std_logic_vector(7 downto 0);
	
	component rom is
        port(
            address : in std_logic_vector(3 downto 0);
            data : out std_logic_vector(7 downto 0)
            );
    end component;
	
	function get_col (col : in integer; cols : in integer) return integer is
	begin
		if col < 0 then
			return cols;
		else
			if col > cols then
				return 0;
			else
				return col;
			end if;
		end if;
	end;
	
begin
	
	rom16x8 : rom
        port map(
            address => address,
            data => data
            );
	
	generate_columns: for i in 0 to 15 generate
	column_inst: entity work.column
        generic map (
            N => 8
        )
        port map (
            CLK => CLK,
            RESET => RESET_STLPEC,
            STATE => STATE(i),
            INIT_STATE => DATA_ALL(i),
            NEIGH_LEFT => STATE(get_col(i-1, 15)),
            NEIGH_RIGHT => STATE(get_col(i+1, 15)),
            DIRECTION => DIRECTION,
            EN => EN
        );
	end generate generate_columns;
	
	
	process (clk) is
	begin
		if rising_edge(clk) then
			R <= STATE(conv_integer(A_adress));
			A_adress <= A_adress + 1;
			A <= A_adress;
		end if;
	
	end process;
	
	
	fsm : process (clk) is
	begin
		if rising_edge(clk) then
			if RESET = '1' then
				FSM_STATE <= st1_load;
			else
				case FSM_STATE is
		
				when  st1_load =>
					RESET_STLPEC <= '0';
					load <= '1';
					if loaded = '1' then	
						load <= '0';
						RESET_STLPEC <= '1';	
						FSM_STATE <= st2_right;
					end if;
				
				when  st2_right =>
					RESET_STLPEC <= '0';
					DIRECTION <= DIR_RIGHT;
					rotation_start <='1';
					
					if rotation_ended = "01" then
						rotation_start <='0';
						FSM_STATE <= st3_left;
					end if;
					
				when  st3_left =>	
						DIRECTION <= DIR_LEFT;
						rotation_start <='1';	
							
						if rotation_ended = "10" then
							rotation_start <='0';
							FSM_STATE <= st4_top;
						end if;

				when  st4_top =>
					DIRECTION <= DIR_TOP;
					rotation_start <='1';

					if rotation_ended = "11" then
						rotation_start <='0';
						
						RESET_STLPEC <= '0';
						load <= '1';
						if loaded = '1' then	
							load <= '0';
							RESET_STLPEC <= '1';	
							FSM_STATE <= st5_animation;
						end if;
						
					end if;
				
				when  st5_animation =>
					RESET_STLPEC <= '0';	
					DIRECTION <= ANIMATION;
					rotation_start <='1';

					if rotation_ended = "00" then
						rotation_start <='0';
						FSM_STATE <= st1_load;
					end if;
					
				when others =>
						FSM_STATE <= st1_load;
				end case;
				
			end if;
		end if;
	end process;
	
	
	load_data : process (clk) is
	begin
		if rising_edge(clk) then
			if load = '1' then 
			
				if address = "0000" then
					loaded <= '1';
				end if;
			
				DATA_ALL(conv_integer(address)) <= data;
				address <= address+1;
				
			else
				loaded <= '0';
				address <= "0001";
			end if;
			
		end if;
	end process;
	
	
	move:	process (clk) is
		variable value : std_logic_vector(1 downto 0) := "00";
		variable three_rotations : std_logic_vector(5 downto 0) := "000000";
		
		variable clk_cnt : std_logic_vector(21 downto 0) := "0000000000000000000000";
		--variable clk_cnt : std_logic_vector(3 downto 0) := "0000";

	begin
		if rising_edge(clk) then
			if rotation_start = '1' then 
				--if clk_cnt = "1111" then
				if clk_cnt = "1111111111111111111111" then
					if value = "01" then
						EN <= '0';
						--clk_cnt := "0000";
						clk_cnt := "0000000000000000000000";
						three_rotations := three_rotations + 1;
					else
						value := value + 1;
						EN <= '1';
					end if;
					
					if FSM_STATE = st4_top then
						if three_rotations = "001010" then
							rotation_ended <= rotation_ended + 1;	-- 16x rotation
						end if;
					end if;					
					
					if three_rotations = "110000" then
						rotation_ended <= rotation_ended + 1;	-- 48x rotation
					end if;
					
				else 
					clk_cnt := clk_cnt +1;
					value := "00";
				end if;
			
			else		
				three_rotations := "000000";
				clk_cnt := "0000000000000000000000";
				--clk_cnt :=	"0000";
			end if;	
		end if;
	
	end process;

end Behavioral;