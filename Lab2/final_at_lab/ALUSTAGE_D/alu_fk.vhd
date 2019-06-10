----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:11:11 02/27/2014 
-- Design Name: 
-- Module Name:    alu_fk - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.std_logic_arith.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_fk is
 Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           zero : out  STD_LOGIC;
           ovf : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end alu_fk;

architecture Behavioral of alu_fk is

signal b_minus : std_logic_vector (31 downto 0 );
signal temp : std_logic_vector (31 downto 0 );	-- to bit 33 xrisimopoihtai gia tin anixneusi tou Cout



begin

b_minus <= -B;

WITH op SELECT
	temp <= 	(A+B) 			when "1111",		--pros8esi
				A+b_minus 	when "0111",		--afairesi
				A and B 		when "0011",		--logiko kai
				not A		when "0001" ,		--!A
				A or B		when "0000",		--logiko H'
			   '0' & A(31 downto 1)	when "1000", 			--olis8isi deksia kata 1 8esi
				A(30 downto 0) & '0' when "1100",			--olis8isi aristera kata 1 8esi
				A(30 downto 0) & A(31) when "1110",		--kukliko rotate aristera kata 1 8esi
				A(0) & A(30 downto 0) when "0101",			--kukliko rotate deksia kata 1 8esi
				temp WHEN OTHERS;
	
	Output <= temp;
	
	zero <= '1' WHEN temp=0 ELSE '0';
--auta trexoun mono se add kai sub!!!		
		WITH A(31) XOR B(31) select
			ovf<= A(31) xor temp(31) when '0',
					'0' when others;
		
		WITH A(31) XOR B(31) select
		Cout<= A(31) when '0',
					not temp(31) when others;
			
	
			
	

end Behavioral;

