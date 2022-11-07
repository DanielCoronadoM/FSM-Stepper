--Algorith state machine

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

signal Qp, Qf	:std_logic_vector(3 downto 0):="0000";	 --hexadecimal

begin
	
	Q <= Qp; 		--Salida de la maquina de estados
	
	
	
	
	--FLip flop D
	FF: process(clk) --Lista de sensibilidad (A que reacciona)
	begin
		if rising_edge(clk) then  --Detector de flancos positivos
			if (rst = '1') then
				Qp <=  x"1"; --S0
				a	<= '0';
				b	<= '0';
				c	<= '0';
				d	<= '0';
			
			elsif (ena = '1') then
				Qp <= Qf;
				
				
			Case Qp is		 --Se usa formato hexadecimal
			
			------------------------------S0
			when x"1" => 	--S0
				if(dir = '1')then
					Qf <= x"2";	--S2
				else
					Qf <= x"8";	--S3
				end if;
				
			-----------------------------S1
			when x"2" =>
				if(dir = '1')then
					Qf <= x"4"; --S2
				else
					Qf <= x"1"; --S0
				end if;
		
			-----------------------------S2
			when x"4" =>
				if(dir = '1')then
					Qf <= x"8"; --S3
				else
					Qf <= x"2"; --S1
				end if;
			
			------------------------------S3
			when others =>
				if(dir = '1')then
					Qf <= x"1"; --S0
				else
					Qf <= x"4"; --S2
				end if;
				
			end case;
			end if;
		end if;
	end process;
	
end architecture;