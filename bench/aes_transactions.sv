
class aes_transaction;
	rand int 	unsigned text[4];
	rand int 	unsigned key[4];
	rand bit 	rst;
	rand bit	ld;
	bit		done;
	int		status;

	int 		ld_density;
	int		rst_density;

	function new (int ld_den, int rst_den);
		ld_density = ld_den;
		rst_density = rst_den;
	endfunction

	constraint density_dist {
		ld dist {0:/100-ld_density, 1:/ld_density};
		rst dist {0:/100-rst_density, 1:/rst_density};
	}

	constraint ld_status {
		(status != 0) -> (ld == 0);
	}

endclass
