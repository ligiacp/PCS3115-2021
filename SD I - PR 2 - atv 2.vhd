entity jkp3 is
	port(
		reset, clock: in bit;
		loadA, loadB: in bit; --! armazenam os gestos
		atualiza: in bit; --! atualiza o resultado z
		a1, a2, a3: in bit_vector(1 downto 0); --! gestos do jogador A para os 3 jogos
		b1, b2, b3: in bit_vector(1 downto 0); --! gestos do jogador B para os 3 jogos
		z: out bit_vector(1 downto 0) --! resultado da disputa
	);
end jkp3;

architecture jkp2 of jkp3 is

	component jokempotriplo is
		port(
			a1, a2, a3 : in bit_vector (1 downto 0); 
			b1 , b2 , b3 : in bit_vector (1 downto 0 ); 
			z : out bit_vector (1 downto 0) 
		);
	end component;
    
    component flipflopd is
		port(
			D, reset, clock, EN: in bit;
			Q: out bit
		);
	end component;
    
    signal jogada_a_1, jogada_a_2, jogada_a_3, jogada_b_1, jogada_b_2, jogada_b_3 , saida_1: bit_vector (1 downto 0);

	begin
    
    --b
    flipflopd_jogada_b_1_1 : flipflopd port map (D => b1(0), reset => reset, clock => clock , EN => loadB, Q => jogada_b_1(0));
    flipflopd_jogada_b_1_2 : flipflopd port map (D => b1(1), reset => reset, clock => clock , EN => loadB, Q => jogada_b_1(1));
    flipflopd_jogada_b_2_1 : flipflopd port map (D => b2(0), reset => reset, clock => clock , EN => loadB, Q => jogada_b_2(0));
    flipflopd_jogada_b_2_2 : flipflopd port map (D => b2(1), reset => reset, clock => clock , EN => loadB, Q => jogada_b_2(1));
    flipflopd_jogada_b_3_1 : flipflopd port map (D => b3(0), reset => reset, clock => clock , EN => loadB, Q => jogada_b_3(0));
    flipflopd_jogada_b_3_2 : flipflopd port map (D => b3(1), reset => reset, clock => clock , EN => loadB, Q => jogada_b_3(1));
    

    
    --a
    flipflopd_jogada_a_1_1 : flipflopd port map (D => a1(0), reset => reset, clock => clock , EN => loadA, Q => jogada_a_1(0));
    flipflopd_jogada_a_1_2 : flipflopd port map (D => a1(1), reset => reset, clock => clock , EN => loadA, Q => jogada_a_1(1));
    flipflopd_jogada_a_2_1 : flipflopd port map (D => a2(0), reset => reset, clock => clock , EN => loadA, Q => jogada_a_2(0));
    flipflopd_jogada_a_2_2 : flipflopd port map (D => a2(1), reset => reset, clock => clock , EN => loadA, Q => jogada_a_2(1));
    flipflopd_jogada_a_3_1 : flipflopd port map (D => a3(0), reset => reset, clock => clock , EN => loadA, Q => jogada_a_3(0));
    flipflopd_jogada_a_3_2 : flipflopd port map (D => a3(1), reset => reset, clock => clock , EN => loadA, Q => jogada_a_3(1));
    
    -- jokempo triplo
    
    jokempo : jokempotriplo port map (a1 => jogada_a_1, a2 => jogada_a_2, a3 => jogada_a_3, b1 => jogada_b_1 , b2 => jogada_b_2 , b3 => jogada_b_3 , z => saida_1);
    
    --flipflop saida
    
    flipflop_saida_1 : flipflopd port map (D => saida_1(0), reset => reset, clock => clock , EN => atualiza, Q => z(0));
    flipflop_saida_2 : flipflopd port map (D => saida_1(1), reset => reset, clock => clock , EN => atualiza, Q => z(1));

end jkp2;



entity jokempotriplo is
	port(
		a1, a2, a3 : in bit_vector (1 downto 0); 
		b1 , b2 , b3 : in bit_vector (1 downto 0 ); 
		z : out bit_vector (1 downto 0) 
	);
end jokempotriplo;

architecture arch3 of jokempotriplo is 
	
    component jokempo is 
		port(
			a : in bit_vector (1 downto 0);
			b : in bit_vector (1 downto 0) ;
			y : out bit_vector (1 downto 0)
		) ;
	end component;
    
    component melhordetres is
		port (
			resultado1 : in bit_vector (1 downto 0 ); 
			resultado2 : in bit_vector (1 downto 0 );
			resultado3 : in bit_vector (1 downto 0 );
			z : out bit_vector (1 downto 0) 
		) ;
	end component;
    
    signal primeiro_gesto, segundo_gesto, terceiro_gesto : bit_vector (1 downto 0 );
    
	begin
    
    	Xprimeiro_gesto: jokempo port map (a => a1, b => b1, y => primeiro_gesto);  
    	Xsegundo_gesto: jokempo port map (a => a2, b => b2, y => segundo_gesto);
    	Xterceiro_gesto: jokempo port map (a => a3, b => b3, y =>  terceiro_gesto);
    	Xz: melhordetres port map (primeiro_gesto, segundo_gesto, terceiro_gesto, z);
        
end arch3;



entity jokempo is
	port(
		a : in bit_vector (1 downto 0);
		b : in bit_vector (1 downto 0) ;
		y : out bit_vector (1 downto 0)
	) ;
end jokempo;

architecture arch1 of jokempo is

    signal a_vence : bit;
    signal empate: bit;
    signal b_vence : bit;

	begin

        a_vence <= '1' when (a = "01" and b = "11") else
        		   '1' when (a = "11" and b = "10") else
                   '1' when (a = "10" and b = "01") else
                   '0';

        empate <= '1' when (a = "01" and b = "01") else
        		  '1' when (a = "11" and b = "11") else
                  '1' when (a = "10" and b = "10") else
                  '0';

        b_vence <= '1' when (b = "01" and a = "11") else
        		   '1' when (b = "11" and a = "10") else
                   '1' when (b = "10" and a = "01") else
                   '0';

        y <= "00" when ( a = "00" or b = "00") else -- espera
             "10" when (a_vence = '1') else  -- A ganha
             "01" when ( b_vence = '1') else --B ganha
             "11" when (empate = '1');  --empate

end arch1;





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