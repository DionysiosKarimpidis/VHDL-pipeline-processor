----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:46:38 03/11/2014 
-- Design Name: 
-- Module Name:    ALUSTAGE - Behavioral 
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

entity ALUSTAGE is
 Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
        RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
        Immed : in  STD_LOGIC_VECTOR (31 downto 0);
        ALU_Bin_sel : in  STD_LOGIC;
        ALU_func : in STD_LOGIC_VECTOR (3 downto 0);
		  ALU_out : out STD_LOGIC_VECTOR (31 downto 0);
		  zero : out STD_LOGIC);

end ALUSTAGE;

architecture Behavioral of ALUSTAGE is

component ALU_mux is
    Port ( RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_sel : in  STD_LOGIC;
           aluMux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component alu_fk is
 Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
        B : in  STD_LOGIC_VECTOR (31 downto 0);
        op : in  STD_LOGIC_VECTOR (3 downto 0);
        Output : out  STD_LOGIC_VECTOR (31 downto 0);
        zero : out  STD_LOGIC);

end component;

signal aluMux_sig : STD_LOGIC_VECTOR (31 downto 0);

begin

aluMux: ALU_mux port map( RF_B => RF_B,
								  Immed => Immed,
								  ALU_sel => ALU_Bin_sel,
								  aluMux_out => aluMux_sig);
								  
alu: alu_fk port map ( A => RF_A,
							  B => aluMux_sig,
							  op => ALU_func,
							  Output => ALU_out,
							  zero => zero);


end Behavioral;

