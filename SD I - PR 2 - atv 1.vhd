
entity hamming is
	port(
		entrada: in bit_vector(9 downto 0); --! 3 gestos mais 4 bits de paridade
		dados : out bit_vector(5 downto 0); --! 3 gestos, corrigindo erros de 1 bit
		erro: out bit --! erro nao corrigido
	);
end hamming;

architecture jkp1 of hamming is
	 
    signal p8 : bit := '0';
    signal p4 : bit := '0';
    signal p2 : bit := '0'; 
    signal p1 : bit := '0';
    signal local_erro : integer := 0;
    
    
    begin
    
    p1 <= entrada(0) xor entrada(4) xor entrada(5) xor entrada (7) xor entrada(8); --certo 
    p2 <= entrada(1) xor entrada(4) xor entrada(6) xor entrada(7) xor entrada(9); --certo e
    p4 <= entrada(2) xor entrada(5) xor entrada(6) xor entrada (7); --certo 
    p8 <= entrada(3) xor entrada(8) xor entrada(9); --certo 
    
    
    --erro
    
    erro <= '1' when ( p8 = '1' and p4 = '0' and p2 ='1' and p1 = '1') else
            '1' when ( p8 = '1' and p4 = '1' and p2 = '0' and p1 = '0') else 
            '1' when ( p8 = '1' and p4 = '1' and p2 = '0' and p1 = '1') else 
            '1' when ( p8 = '1' and p4 = '1' and p2 = '1' and p1 = '0') else
            '1' when ( p8 = '1' and p4 = '1' and p2 = '1' and p1 = '1') else
            '0';
    
    -- soma dos erros
    
    local_erro <=  10 when (p1 = '0' and p2 = '1' and p4 = '0' and p8 = '1') else
                   9 when (p1 = '1' and p2 = '0' and p4 = '0' and p8 = '1') else
    			   7 when (p1 = '1' and p2 = '1' and p4 = '1' and p8 = '0') else
                   6 when (p1 = '0' and p2 = '1' and p4 = '1' and p8 = '0') else
                   5 when (p1 = '1' and p2 = '0' and p4 = '1' and p8 = '0') else
                   3 when (p1 = '1' and p2 = '1' and p4 = '0' and p8 = '0') else
                   0; 
    
    --dados
                
  
    dados(0) <= '1' when (entrada(4) = '0' and local_erro = 3) else
    			'0' when (entrada(4) = '1' and local_erro = 3) else 
    			 entrada(4);
               
    dados(1) <= '1' when (entrada(5) = '0' and local_erro = 5) else
    			'0' when (entrada(5) = '1' and local_erro = 5) else 
    			entrada(5);
    	
    dados(2) <= '1' when (entrada(6) = '0' and local_erro = 6) else
    			'0' when (entrada(6) = '1' and local_erro = 6) else 
    			entrada(6);
                
    dados(3) <= '1' when (entrada(7) = '0'  and local_erro = 7) else
    			'0' when (entrada(7) = '1' and local_erro = 7) else 
    			entrada(7);
                
    dados(4) <= '1' when (entrada(8) = '0' and local_erro = 9) else
    			'0' when (entrada(8) = '1' and local_erro = 9) else 
    			entrada(8);
                
	dados(5) <= '1' when (entrada(9) = '0' and local_erro = 10) else
    			'0' when (entrada(9) = '1' and local_erro = 10) else 
    			entrada(9);
                
        
end jkp1;