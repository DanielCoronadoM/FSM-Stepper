--Algorith state machine

library ieee;
use ieee.std_logic_1164.all; --> Operacione logicas


entity asm_example is
	port(
		clk, ena, rst 	:in std_logic;
		x				:in std_logic;
		Q				:out std_logic_vector(3 downto 0)
	);
end entity;

architecture functional of asm_example is

signal Qp, Qf	:std_logic_vector(3 downto 0):="0000";

begin
	
	Q <= Qp; 		--Salida de la maquina de estados
	
	ASM : process(Qp, x)   --Lista de sensibilidad	(Donde estoy, hacia donde voy)
	begin	   
		Case Qp is		 --Se usa formato hexadecimal
			
			------------------------------S0
			when x"1" => 	--S0
				if(x = '1')then
					Qf <= x"2";	--S2
				else
					Qf <= x"8";	--S3
				end if;
				
			-----------------------------S1
			when x"2" =>
				if(x = '1')then
					Qf <= x"4"; --S2
				else
					Qf <= x"1"; --S0
				end if;
		
			-----------------------------S2
			when x"4" =>
				if(x = '1')then
					Qf <= x"8"; --S3
				else
					Qf <= x"2"; --S1
				end if;
			
			------------------------------S3
			when others =>
				if(x = '1')then
					Qf <= x"1"; --S0
				else
					Qf <= x"4"; --S2
				end if;
				
			end case;
	end process;
	
	
	--FLip flop D
	FF: process(clk) --Lista de sensibilidad (A que reacciona)
	begin
		if rising_edge(clk) then  --Detector de flancos positivos
			if (rst = '1') then
				Qp <=  x"1"; --S0
			elsif (ena = '1') then
				Qp <= Qf;    
			end if;
		end if;
	end process;
	
end architecture;