--Dispositivo U1: control de velocidad

library ieee;
use ieee.std_logic_1164.all; --> Operacione logicas
use ieee.numeric_std.all;	 --> Operaciones aritmeticas

entity frec_out is
	port(
		--spd			:in std_logic_vector(no vector dimension yet);
		clk, ena, rst 	:in std_logic;
		f				:out std_logic
	);
end entity;

architecture functional of frec_out is
signal count	:unsigned(19 downto 0):= (others => '0');
signal spd		:unsigned(19 downto 0);

begin

	f 		<= '1' when count>spd else '0';	--frecuencia de salida

	--Contador y comparador
	contador: process(clk) --Se cambiará a "bt"
	begin
		if rising_edge(clk) then  --Detector de flancos positivos
			if (rst = '1') then
				count <= (others => '0');
			
			elsif (ena = '1') then
				count <= count + 1;	
				if (count > spd) then
					count <= (others => '0');
				end if;	
			end if;	
			
		end if;
	end process;
	
	
	
end architecture;