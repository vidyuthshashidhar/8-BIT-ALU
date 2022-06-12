`timescale 1ns / 1ps
module alu_8bit_tb;


	reg [7:0] a;
	reg [7:0] b;
	reg cin;
	reg bin;
	reg [3:0] sel;

	
	wire [7:0] out1;
	wire [7:0] out2;
	/*wire [7:0] out3;
	wire [7:0] out4;
	*/
	wire cout;

		alu_8bit uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.bin(bin), 
		.out1(out1), 
		.out2(out2), 
		.cout(cout), 
		.sel(sel)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		cin = 0;
		bin = 0;
		sel = 0;
		#100;		
	end
      always begin
		a = $random;
		b = $random;
		cin = $random;
		bin = $random;
		sel = 4'b0000;
		#10;
end
endmodule
