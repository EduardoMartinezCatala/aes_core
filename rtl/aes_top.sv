//aes top
//include both aes_cipher_top and aes_inv_cipher_top
`timescale 1ns/1ps 

module aes_top(ifc.dut d);
    logic ld_e;
    logic ld_d;
 
    logic done_e;
    logic done_d;
    logic kdone;
    logic  [127:0] text_out_e;
    logic [127:0] text_out_d;
	
    always_comb begin
        if (d.mode == '0) begin
            ld_e = d.ld;
            assign d.done = done_e;
            assign d.kdone = '0;
	    assign d.text_out = text_out_e;
        end else if (d.mode == '1) begin
            ld_d = d.ld;
            assign d.done = done_d;
            assign d.kdone = kdone;
	    assign d.text_out = text_out_d;
        end
    end

 

	aes_cipher_top cipher (
			.clk(d.clk),	
			.rst(d.rst),
			.ld(ld_e),
			.key(d.key),
			.text_in(d.text_in),
			.text_out(text_out_e),
			.done(done_e),
			.sa00(d.sa00),
			.sa01(d.sa01),
			.sa02(d.sa02),
			.sa03(d.sa03),
			.sa10(d.sa10),
			.sa11(d.sa11),
			.sa12(d.sa12),
			.sa13(d.sa13),
			.sa20(d.sa20),
			.sa21(d.sa21),
			.sa22(d.sa22),
			.sa23(d.sa23),
			.sa30(d.sa30),
			.sa31(d.sa31),
			.sa32(d.sa32),
			.sa33(d.sa33),

			.sa00_sub(d.sa00_sub),
			.sa01_sub(d.sa01_sub),
			.sa02_sub(d.sa02_sub),
			.sa03_sub(d.sa03_sub),
			.sa10_sub(d.sa10_sub),
			.sa11_sub(d.sa11_sub),
			.sa12_sub(d.sa12_sub),
			.sa13_sub(d.sa13_sub),
			.sa20_sub(d.sa20_sub),
			.sa21_sub(d.sa21_sub),
			.sa22_sub(d.sa22_sub),
			.sa23_sub(d.sa23_sub),
			.sa30_sub(d.sa30_sub),
			.sa31_sub(d.sa31_sub),
			.sa32_sub(d.sa32_sub),
			.sa33_sub(d.sa33_sub)
			);


    aes_inv_cipher_top decipher (
        .clk(d.clk),
        .rst(d.rst),
        .ld(ld_d),
        .kld(d.kld),
        .done(done_d),
        .kdone(kdone),
        .key(d.key),
        .text_in(d.text_in),
        .text_out(text_out_d)
        );



endmodule
