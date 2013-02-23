class aes_env;
    int max_transactions;
    int warmup;
    bit verbose;
    int reset_density, ld_density;

    function configure(string filename);
        int file, value, seed, chars_returned;
        string param;
        file = $fopen(filename, "r");
        while(!$feof(file)) begin
            chars_returned = $fscanf(file, "%s %d", param, value);
            if ("RANDOM_SEED" == param) begin
                seed = value;
                $srandom(seed);
            end
	    else if("RESET_DENSITY" == param) begin
	    	reset_density = value;
	    end
	    else if("LD_DENSITY" == param) begin
		ld_density = value;
	    end
	    else if("VERBOSE" == param) begin
		verbose = value;
	    end
	    else if("WARMUP" == param) begin
		warmup = value;
	    end
	    else if("MAX_TRAN" == param) begin
		max_transactions = value;
	    end
            else begin
                $display("Never heard of a: %s", param);
                $exit();
            end
        end
    endfunction
endclass

