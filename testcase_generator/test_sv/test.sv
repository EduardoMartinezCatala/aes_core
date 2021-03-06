class aes_transaction;
	rand int  text[4];
	rand int  key[4];
endclass

program tb (ifc.bench ds);

import "DPI-C" function void rebuild_text ( input int  txt, input int i);
import "DPI-C" function void rebuild_key ( input int ky , input int i);
import "DPI-C" function void generate_ciphertext ();
import "DPI-C" function int signed get_ciphertext (input int i);

aes_transaction t;
int signed  ctext[4];
bit id_t = '1;

int temp = 0;

initial	begin

	repeat (15) begin

		if (temp == 0) begin
			t = new();
			t.randomize();
		end	

		$display ("%t : %s \n", $realtime, "Driving new values");

		/*driving dut inputs*/
	
		ds.cb.rst		<=	'0; 		//t.rst;

		if (temp == 0) begin
			ds.cb.id		<= 	id_t;	end
		else	begin
			ds.cb.id		<=	'0;	end
		
		ds.cb.text_in[31:0] 	<= 	t.text[0];
		ds.cb.text_in[63:32]	<= 	t.text[1]; 		
		ds.cb.text_in[95:64 ]	<= 	t.text[1]; 		
		ds.cb.text_in[127:96]	<= 	t.text[1]; 		

		ds.cb.key[31:0] 	<= 	t.key[0];
		ds.cb.key[63:32]	<= 	t.key[1]; 		
		ds.cb.key[95:64 ]	<= 	t.key[1]; 		
		ds.cb.key[127:96]	<= 	t.key[1]; 	
		
		temp = temp + 1;

		@(ds.cb);
		
		/*sending data to software model*/

		if (temp == 0) begin

			rebuild_text(t.text[0], 0);
			rebuild_text(t.text[1], 1);
			rebuild_text(t.text[2], 2);
			rebuild_text(t.text[3], 3);

			rebuild_key(t.key[0], 0);
			rebuild_key(t.key[1], 1);
			rebuild_key(t.key[2], 2);
			rebuild_key(t.key[3], 3);
	
	//		$display("SV: randomized key : %d%d%d%d", t.key[0], t.key[1], t.key[2], t.key[3] );
	//		$display("SV: randomized text : %d%d%d%d", t.text[0], t.text[1], t.text[2], t.text[3] );

			generate_ciphertext ();
	
			ctext[0] = get_ciphertext(0);
			ctext[1] = get_ciphertext(1);
			ctext[2] = get_ciphertext(2);
			ctext[3] = get_ciphertext(3);

		end else if (temp == 12) begin
				
			printf ("checker goes here");

			$display("SV: cipher text : %d%d%d%d", ctext[0], ctext[1], ctext[2], ctext[3] );
		end 

		if (temp == 12)	begin
			temp == 0;	
		end



	end
end


endprogram



