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