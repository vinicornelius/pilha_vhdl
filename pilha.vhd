library IEEE;
use IEEE.std_logic_1164.all;

entity pilha is
  Port ( 
			CLK: in std_logic;
			RESET: in std_logic;
			DATA_IN : in std_logic_vector(7 downto 0);
			POP : in std_logic;
			PUSH : in std_logic;
			DATA_OUT : out std_logic_vector(7 downto 0);
			LED : out std_logic_vector(7 downto 0)
			);
end entity;

architecture principal of pilha is
	type DATA_ARRAY is array (integer range <>) of std_logic_vector(0 to 7);
	signal DATA: DATA_ARRAY (0 to 7);
	SIGNAL estado : INTEGER RANGE 4 DOWNTO 0;
	
BEGIN
	PROCESS (CLK, RESET)
	variable PTR: integer range 0 to 8;
	variable cont: integer range 0 to 20;
		BEGIN
			IF RESET = '0' THEN -- estado inicial
				estado <= 0;
				PTR:= 0;
				DATA <=(others =>(others => '0'));
				DATA_OUT <=(others => '0');
				
			ELSIF (CLK'EVENT and CLK ='1') THEN -- ciclo de estados
				CASE estado IS
					WHEN 0 => -- INTERMEDIARIO	
						IF PUSH = '1' THEN 
							estado <= 1;
						ELSIF POP = '1' THEN 
							estado <= 2; 		
						ELSE estado<=0;
						END IF;

					WHEN 1 => -- Estado de Push
						IF PTR /= 8 THEN
							DATA(PTR) <= DATA_IN;
							PTR := (PTR+1);
							estado <= 3;
						ELSE estado <= 3;
						END IF;
						
					WHEN 2 => -- Estado de Pop
						IF PTR /= 0 THEN
							PTR := (PTR-1);
							estado <= 3;
						ELSIF PTR = 0 THEN 
							DATA(PTR) <= (others => '0');
							estado <= 4;
						ELSE estado <= 4;
						END IF;
						
					WHEN 3 => --Estado de espera	
						IF PUSH = '1' THEN	
							estado <= 3;
						ELSIF POP = '1' THEN
							estado <= 3;
						ELSIF PUSH = '0' AND POP = '0' THEN
							estado <= 4;
						END IF;
					
					WHEN 4 => --Saída dos dados
						
						DATA_OUT <= DATA(PTR);
						estado <= 0;
												
						IF PTR = 1 then 
							LED(0) <= '1';
						ELSE
							LED(0) <= '0';
						END IF;
						
						IF PTR = 2 then 
							LED(1) <= '1';
						ELSE
							LED(1) <= '0';
						END IF;
							
						IF PTR = 3 then 
							LED(2) <= '1';
						ELSE
							LED(2) <= '0';
						END IF;
						
						IF PTR = 4 then 
							LED(3) <= '1';
						ELSE
							LED(3) <= '0';
						END IF;
						
						IF PTR = 5 then 
							LED(4) <= '1';
						ELSE
							LED(4) <= '0';
						END IF;
						
						IF PTR = 6 then 
							LED(5) <= '1';
						ELSE
							LED(5) <= '0';
						END IF;
						
						IF PTR = 7 then 
							LED(6) <= '1';
						ELSE
							LED(6) <= '0';
						END IF;
							
						IF PTR = 8 then 
							LED(7) <= '1';
						ELSE
							LED(7) <= '0';
						END IF;
						
					
						
						
						
				END CASE;
			END IF;
		END PROCESS;
end architecture;