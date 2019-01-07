-- 3.1
entity if_state is
	port (a : in bit;
		b : out bit);
end entity if_state;
-----------------------------
architecture behavior of if_state is
begin
	main_process : process (a) is
	begin
		if a = '1' then
			b <= '1';
		end if;
	end process if_state;
end architecture;

-- 3.2
library ieee;
use ieee.std_logic_1164.all;

-- Defined year and days as subtypes of integers 
-- so I could perform the modulus operation on them
package type_defs is
    subtype year is integer range 0 to 10000;
    subtype days is integer range 1 to 31;
end package type_defs;

use work.type_defs.all;

entity leap_year is
	port (a : in year;
		    b : out days);
end entity leap_year;
-------------------------------
architecture behavior of leap_year is
begin
	days_of_month : process (a) is
		variable days_in_February : days;
	begin
		-- I had mistakenly written “year mod year(4) = 4” which
		-- does nothing since 'year' is not a signal
		if (a mod year(4) = 0 or a mod year(400) = 0) nand a mod year(100) = 0 then
			-- THe syntax checker didn't like me assigning 'days_in_February' with
			-- the '<=' operator, so I switched it to ':='. I'm still exploring
			-- why it didn't like the original version.
			days_in_February := 29;
		else
			days_in_February := 28;
		end if;
		assert days_in_February = 28 or days_in_February = 29
		    report "Calculated days is invalid."
		    severity failure;
		b <= days_in_February;
	end process days_of_month;
end architecture behavior;
