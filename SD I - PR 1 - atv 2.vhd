entity melhordetres is
	port (
		resultado1 : in bit_vector (1 downto 0 ); 
		resultado2 : in bit_vector (1 downto 0 );
		resultado3 : in bit_vector (1 downto 0 );
		z : out bit_vector (1 downto 0) 
	) ;
end melhordetres;

architecture arch2 of melhordetres is

	signal maioria_a : bit;
    signal maioria_b : bit;
    signal um_a : bit;
    signal um_b : bit;
    
	begin
    
    maioria_a <= '1' when (resultado1 = "10" and resultado2 = "10") else -- A ganha 2 de 3
    			 '1' when (resultado1 = "10" and resultado3 = "10") else
                 '1' when (resultado2 = "10" and resultado3 = "10") else
                 '0';
    maioria_b <= '1' when (resultado1 = "01" and resultado2 = "01") else -- B ganha 2 de 3
    			 '1' when (resultado1 = "01" and resultado3 = "01") else
                 '1' when (resultado2 = "01" and resultado3 = "01") else
                 '0';
                 
    um_a <= '1' when (resultado1 = "10" and resultado2 = "11" and resultado3= "11") else -- A ganha 1 com dois empates
            '1' when (resultado1 = "11" and resultado2 = "10" and resultado3= "11") else
            '1' when (resultado1 = "11" and resultado2 = "11" and resultado3= "10") else
            '0';
    
    um_b <= '1' when (resultado1 = "01" and resultado2 = "11" and resultado3= "11") else -- B ganha 1 com dois empates
            '1' when (resultado1 = "11" and resultado2 = "01" and resultado3= "11") else
            '1' when (resultado1 = "11" and resultado2 = "11" and resultado3= "01") else
            '0';
    
    z <= "00" when (resultado1 = "00" or resultado2 = "00" or resultado3 = "00") else -- espera
    	 "01" when (maioria_b = '1' or um_b = '1') else -- B ganha
         "10" when (maioria_a = '1' or um_a = '1') else -- A  ganha 
         "11"; -- empate
    

end arch2;