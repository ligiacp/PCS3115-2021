entity bass_hero_versus is
	port (clk, reset: in bit;
		target: in bit_vector (3 downto 0);
		played: in bit_vector (3 downto 0);
		jam: in bit;
		score: out bit_vector (2 downto 0);
		cheers: out bit );
end bass_hero_versus;

architecture hero2 of bass_hero_versus is

	signal presente, futuro, futuro_jam : bit_vector (2 downto 0);
    
	begin
    	
      rising: process (reset, clk) 	-- bloco de memória
	begin		 				    -- sensível a clock e reset
		if (reset = '1' and rising_edge(clk)) then 
			presente <= "000";      -- estado inicial (reset assíncrono)
		elsif (rising_edge(clk) and jam = '0' and reset = '0') then -- borda subida
            	presente <= futuro;
        elsif (jam = '1' and rising_edge(clk) and reset ='0') then
            	presente <= futuro_jam;
                
		end if;
	end process;

    
		futuro <= "110" when (presente = "110") and (target /= played) else 
        		  "111" when (presente = "110") and (target = played) else 
                  
                  "110" when (presente = "111" ) and (target /= played) else
        		  "000" when (presente = "111" ) and (target = played) else
                  
                  "111" when (presente = "000" ) and (target /= played) else
        		  "001" when (presente = "000" ) and (target = played) else
                  
                  "000" when (presente = "001") and (target /= played) else
        		  "010" when (presente = "001") and (target = played) else
                  
                  "001" when (presente = "010") and (target /= played) else
        		  "100" when (presente = "010") and (target = played) else
                  
                  "001" when (presente = "100") and (target /= played) else
        		  "100" when (presente = "100") and (target = played)else 
                  "000";
    
                 
                  
		futuro_jam <= "110" when (presente = "110") else -- -2 pra -2
        			  "110" when (presente = "111") else -- -1 pra -2
                      "110" when (presente = "000") else -- 0 pra -2
                      "111" when (presente = "001") else -- 1 pra -1
                      "000" when (presente = "010") else -- 2 pra 0
                      "000" when (presente = "100") ;    -- 2 cheers pra zero
    
    	score <= "010" when (presente = "100") else
        		  presente;
                 
		cheers <= '1' when (presente = "100") else
        		  '0';
    
end hero2;