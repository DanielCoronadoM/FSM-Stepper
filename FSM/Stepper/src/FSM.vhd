--Algorith state machine

-- dir = 1 : Giro en sentido horario
-- dir = 0 : Giro en sentido antihorario

library ieee;
use ieee.std_logic_1164.all; --> Operacione logicas


entity FSM is
	port(
		dir				:in std_logic;
		clk, ena, rst 	:in std_logic;
		a, b, c, d		:out std_logic;
		Q				:out std_logic_vector(3 downto 0)
	);
end entity;

architecture functional of FSM is

signal Qp, Qf	:std_logic_vector(3 downto 0):="0000";	 

begin
	
	Q <= Qp; 		--Salida de la maquina de estados
	
	
	
	
	--FLip flop D
	FF: process(clk) --Lista de sensibilidad (A que reacciona)
	begin
		if rising_edge(clk) then  --Detector de flancos positivos
			if (rst = '1') then
				Qp <=  x"1"; --Step_1
				
				--Valores de reseteo
				a	<= '0';
				b	<= '0';
				c	<= '0';
				d	<= '0';
			
			elsif (ena = '1') then
				Qp <= Qf;
				
				--Valores predeterminados
				a	<= '0';
				b	<= '0';
				c	<= '0';
				d	<= '0';
				
			Case Qp is		 --
			
			------------------------------Step_1
			when x"1" => 	
				a	<= '1';
				b	<= '0';
				c	<= '0';
				d	<= '0';
				
				if(dir = '1')then
					Qf <= x"2";	--S2
				else
					Qf <= x"8";	--S8
				end if;
				
			-----------------------------Step_2
			when x"2" =>
				a	<= '1';
				b	<= '1';
				c	<= '0';
				d	<= '0';
				
				if(dir = '1')then
					Qf <= x"3"; --S3
				else
					Qf <= x"1"; --S1
				end if;
		
			-----------------------------Step_3
			when x"3" =>
				a	<= '0';
				b	<= '1';
				c	<= '0';
				d	<= '0';
				
				if(dir = '1')then
					a	<= '0';
					b	<= '1';
					c	<= '0';
					d	<= '0';
					Qf <= x"4"; --S4
				else
					Qf <= x"2"; --S2
				end if;
				
			-----------------------------Step_4-------------------
			when x"4" =>
				a	<= '0';
				b	<= '1';
				c	<= '1';
				d	<= '0';
				
				if(dir = '1')then
					Qf <= x"5"; --S5
				else
					Qf <= x"3"; --S3
				end if;
				
			-----------------------------Step_5
			when x"5" =>
				a	<= '0';
				b	<= '0';
				c	<= '1';
				d	<= '0';
				
				if(dir = '1')then
					Qf <= x"6"; --S6
				else
					Qf <= x"4"; --S4
				end if;
				
			-----------------------------Step_6
			when x"6" =>
				a	<= '0';
				b	<= '0';
				c	<= '1';
				d	<= '1';
				
				if(dir = '1')then
					Qf <= x"7"; --S7
				else
					Qf <= x"5"; --S5
				end if;
				
			-----------------------------Step_7
			when x"7" =>
				a	<= '0';
				b	<= '0';
				c	<= '0';
				d	<= '1';
				
				if(dir = '1')then
					Qf <= x"8"; --S8
				else
					Qf <= x"6"; --S6
				end if;
			
			------------------------------Step_8
			when others =>
				a	<= '1';
				b	<= '0';
				c	<= '0';
				d	<= '1';
				if(dir = '1')then
					Qf <= x"1"; --S1
				else
					Qf <= x"7"; --S7
				end if;
				
			end case;
			end if;
		end if;
	end process;	
end architecture;