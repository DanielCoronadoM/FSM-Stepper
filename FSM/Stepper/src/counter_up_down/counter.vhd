--Contador ascendente/descendente arquitectura funcional

--vd = 0 cuenta ascendente
--vd = 1 cuenta descendente

library ieee;
use ieee.std_logic_1164.all; --> Operacione logicas
use ieee.numeric_std.all;	 --> Operaciones aritmeticas

entity contador_16b is
	port(
		clk, ena, rst	:in std_logic;
		vd				:in std_logic;
		Count			:out std_logic_vector(15 downto 0)
	);
end entity;

architecture structural of contador_16b is

	
component adder_nbits is
	generic(N:integer);
	port(
		A, B 	:in std_logic_vector(N-1 downto 0);
		Y		:out std_logic_vector(N-1 downto 0)
	);
end component;

component reg_nbits is
	generic(N:integer);
	port(
		clk, rst, ena 	:in std_logic;
		D				:in std_logic_vector(N-1 downto 0);
		Q				:out std_logic_vector(N-1 downto 0)
	);
	
end component;
--Conectar-------------------
signal mux_0, As, Ys : std_logic_vector(15 downto 0);	
begin
	UO : adder_nbits generic map(N=>16)		--Tipo de instanciacion por nombre
		port map(
			A =>	As,
			B =>	mux_0,
			Y =>	Ys
			
		);
	U1	: reg_nbits generic map(N=>16)
		port map(
			clk => clk,
			ena => ena,
			rst => rst,
			D	=> Ys,
			Q	=> As
		);
	
	mux_0 <= x"0001" when vd='0' else x"FFFF";	 --Multiplexor
	
	Count <= As;	--Salida del contador
	
end architecture;