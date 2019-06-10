----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:22:46 03/24/2014 
-- Design Name: 
-- Module Name:    Control - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control is
	Port(	PC_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           ALU_Bin_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           Mem_Din_sel : out  STD_LOGIC;
           Mem_Dout_sel : out  STD_LOGIC;
           Mem_WrEn : out  STD_LOGIC;
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           zero : in  STD_LOGIC);
end Control;

architecture Behavioral of Control is

TYPE State is (Reset, instrRead, nop1, nop2, r1, r2, r3, ori1, ori2, addi1, addi2, andi1, andi2, li1, li2, l1, l2, l3, lb0, lw0, s1, sb0, sw0, b1, beq1, beq2, bz1, bz0, bneq1, bneq2);
signal st: State; 

begin

	process
		begin
		
		WAIT UNTIL clk'EVENT AND clk='1';
		if (rst ='1') then
			st <= Reset;
--			PC_LdEn <= '0';
--       RF_WrEn <= '0'; 
--			Mem_WrEn <= '0';
		else
			case st is
				when Reset =>
--						PC_LdEn <= '0';
--						RF_WrEn <= '0'; 
--						Mem_WrEn <= '0';
							st<= instrRead;

				when instrRead =>
						--eksasfalizoume oti ta simantika simata 8a einai 0 ksekinontas ka8e entoli
--						RF_WrEn <= '0'; 
--						Mem_WrEn <= '0';
						--kai sinexizei..
						if (Instr = "00000000000000000000000000000000") then
							st<= nop1;
						elsif (Instr (31 downto 26) = "100000") then
							st<= r1;
						elsif (Instr (31 downto 26) = "111110") then
							st<= ori1;
						elsif (Instr (31 downto 26) = "111000") then
							st<= addi1;
						elsif (Instr (31 downto 26) = "111100") then
							st<= andi1;
						elsif (Instr (31 downto 26) = "110000") then
							st<= li1;
						elsif (Instr (31 downto 26) = "000011") OR (Instr (31 downto 26) = "001111") then
							st<= l1;
						elsif (Instr (31 downto 26) = "000111") OR (Instr (31 downto 26) = "011111") then
							st<= s1;
						elsif (Instr (31 downto 26) = "111111") then
							st<= b1;
						elsif (Instr (31 downto 26) = "000000") then
							st<= beq1;
						elsif (Instr (31 downto 26) = "000001") then
							st<= bneq1;									
						else
							st<= nop1; --se agnwsti entoli feromaste opws sti nop,pame stin epomeni
						end if;
				when nop1 =>
						st<= nop2;
				when nop2 =>
						st<= instrRead;
				when r1 =>
						st<= r2;
				when r2 =>
						st<= r3;
				when r3 =>
						st<= instrRead;
				when ori1 =>
						st<=ori2;
				when ori2 =>
						st<= r3;
				when addi1 =>
						st<= addi2;
				when addi2 =>
						st<= r3;
				when andi1 =>
						st<= andi2;
				when andi2 =>
						st<= r3;
				when li1 =>
						st<= li2;
				when li2 =>
						st<= instrRead;
				when l1 =>
						st<=l2;
				when l2 =>
						st<= l3;
				when l3 =>
						if (Instr (31 downto 26) = "000011") then
							st<= lb0;
						else
							st<= lw0;
						end if;
				when lb0 =>
						st<= instrRead;
				when lw0 =>
						st<= instrRead;
						
				when s1 =>
						if (Instr (31 downto 26) = "000111") then
							st<= sb0;
						else 
							st<= sw0;
						end if;
				when sw0 =>
						st<= li2;
				when sb0 =>
						st<= li2;
				when b1 =>
						st<= li2;
				when beq1 =>
						st<= beq2;
				when beq2 =>
						if zero='1' then 
							st<= bz1;
						else
							st<= bz0;
						end if;
				when bz1 =>
						st<= li2;
				when bz0 =>
						st<= li2;
				when bneq1 =>
						st<= bneq2;
				when bneq2 =>
						if zero='1' then 
							st<= bz0;
						else
							st<= bz1;
						end if;
			end case;
		end if; 
		
	end process;
	
	  with st select
	  PC_LdEn <= '1' when nop1,
					 '1' when r2,
					 '1' when ori2,
					 '1' when addi2,
					 '1' when andi2,
					 '1' when li1,
					 '1' when b1,
					 '1' when bz1,
					 '1' when bz0,
					 '1' when l3,
					 '1' when sb0,
					 '1' when sw0,
					 '0' when others;
					 
	  with st select
	  PC_sel <= '1' when b1,
				   '1' when bz1,
					'0' when others;
	  with st select			
	  RF_B_sel <= '1' when s1,
				  -- '1' when s2,
					  '1' when beq1,
					  '1' when beq2,
					  '1' when bneq1,
					  '1' when bneq2,
					  '0' when others;
	  
	  RF_WrEn <= '1' when st = r2 else
					 '1' when st = addi2 else
					 '1' when st = ori2 else
					 '1' when st = andi2 else
					 '1' when st = li1 else
					 '1' when st = l3 else
					 '0';
		
	  RF_WrData_sel <= "10" when st = li1 else
							 "01" when st = l3 else
					       "00";
	  
	  ALU_Bin_sel <= '1' when st = ori2 else
						  '1' when st = addi2 else
						  '1' when st = andi2 else
						  '1' when st = l2 else
						  '1' when st = sb0 else
						  '0';
	  ALU_func <= Instr (4 downto 1) when  st = r2 else
					  "0000" when  st = ori2 else
					  "1111" when  st = addi2 else
					  "0011" when  st = andi2 else
					  "1111" when  st = l2 else
					  "1111" when  st = sb0 else
					  "1111" when  st = sw0 else
					  "0111" when  st = beq2 else
					  "0111" when  st = bneq2 else
					  "0000";
	 
	 Mem_Din_sel <= '1' when  st = sb0  else
						 '0';
	  
	  
	 Mem_Dout_sel <= '1' when st = lb0 else
						  '0';
	 
	 Mem_WrEn <= '1' when st = sb0 else
					 '1' when st = sw0 else
					 '0';
end Behavioral;

