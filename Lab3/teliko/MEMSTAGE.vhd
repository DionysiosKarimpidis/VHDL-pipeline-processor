----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:35:16 03/12/2014 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

entity MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEnable : in  STD_LOGIC;
           ALU_MEM_addr : in  STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_in : in  STD_LOGIC_VECTOR (31 downto 0);
			  MemDinsel : in  STD_LOGIC;
			  MemDoutsel : in  STD_LOGIC;
			  loadMuxOut : out  STD_LOGIC_VECTOR (31 downto 0));
--         MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

component Data_MEM is
port (
	clk: in std_logic;
	we: in std_logic;
	addr: in std_logic_vector(9 downto 0);
	din: in std_logic_vector(31 downto 0);
	dout : out std_logic_vector(31 downto 0));
end component;

component storeMux is
    Port ( Rf_b : in  STD_LOGIC_VECTOR (31 downto 0);
           Mem_Din_sel : in  STD_LOGIC;
           sMuxOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component loadMux is
    Port ( loadMux_in : in  STD_LOGIC_VECTOR (31 downto 0);
           Mem_Dout_sel : in  STD_LOGIC;
           lmux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal storeSignal, dout_sig : STD_LOGIC_VECTOR (31 downto 0);
begin

mem_port: Data_MEM port map (	clk => clk,
										we => Mem_WrEnable,
										addr => ALU_MEM_addr(11 downto 2),
										din => storeSignal,
										dout => dout_sig);

store_port: storeMux port map ( Rf_b => RF_B_in,
										  Mem_Din_sel => MemDinsel,
										  sMuxOut => storeSignal);

load_port: loadMux port map ( loadMux_in => dout_sig,
										Mem_Dout_sel => MemDoutsel,
										lmux_Out => loadMuxOut);



end Behavioral;

