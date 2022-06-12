`timescale 1ns / 1ps
module alu_8bit(a,b,cin,bin,out1,out2,cout,sel);
input [7:0] a;
input [7:0] b;
input cin;
input bin;
input[3:0] sel;
output reg [7:0] out1;
output reg [7:0] out2;
/*output reg [7:0] out3;
output reg [7:0] out4;
*/
output reg cout;

wire [7:0] sum_out,dif_out,shift_1,shift_2,mul_1,div_1,cmp_1,cmp_2;
wire carry_out1,bo_out;

		adder_8bit alu1(.val1(a),.val2(b),.sum(sum_out),.cin1(cin),.carry(carry_out1));
		
		fullsub_8bit alu2 (.a(a),.b(b),.bin(bin),.dif(dif_out),.bo(bo_out));
		
		shiftop alu3( .a(a), .y(shift_1),.z(shift_2));
		
		mul alu4(.a(a),.y(mul_1));
		
		div alu5(.a(a),.z(div_1));
		
		//log_op alu6 (.a(a),.b(b),.y1(y1),.y2(y2),.y3(y3),.y4(y4),.y5(y5));
		
		comp_num alu7 (.a(a),.b(b),.cmp_a(cmp_1),.cmp_b(cmp_2));
	



always@(*)
begin

	case(sel[3:0])
	4'b0000:
	begin
	out1[7:0]=sum_out;
	out2[7:0]=8'b00000000;
	cout=carry_out1;
	end
	4'b0001:
	begin
	out1[7:0]=dif_out;
	out2[7:0]=8'b00000000;
	cout=bo_out;
	end
	
	4'b0010:
	begin
	out1=shift_1;
	out2=shift_2;
	end
	
	
	4'b0011:
	begin
	out1=mul_1;
	end
	
	
	4'b0100:
	begin
	out1=div_1;
	end
	
	
	4'b0101:
	begin
	out1[7:0] =cmp_1 ;
	out2[7:0] =cmp_2 ;
	end
	
	
	default:
	out1[7:0] = 8'b00000000;

endcase
	end
	endmodule
/*	4'b0111:
	4'b1000:
	4'b1001:
	4'b1010:
	4'b1011:
	4'b1100:
	4'b1101:
	4'b1110:
	4'b1111:
*/

/////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
module fa(a,b,sum,cin,carry);
input a,b,cin;
output sum,carry;

assign sum=a^b^cin;
assign carry=((a&b)|(b&cin)|(cin&a));

endmodule
///////////////////////////////////////////////////////////
//////////////////////////
module adder_8bit(val1,val2,sum,cin1,carry);
input [7:0]val1;
input[7:0]val2;
input cin1;
output[7:0]sum;
output carry;
wire co1,co2,co3,co4,co5,co6,co7;
fa b1(.a(val1[0]),.b(val2[0]),.sum(sum[0]),.cin(cin1),.carry(co1));

fa b2(.a(val1[1]),.b(val2[1]),.sum(sum[1]),.cin(co1),.carry(co2));

fa b3(.a(val1[2]),.b(val2[2]),.sum(sum[2]),.cin(co2),.carry(co3));

fa b4(.a(val1[3]),.b(val2[3]),.sum(sum[3]),.cin(co3),.carry(co4));

fa b5(.a(val1[4]),.b(val2[4]),.sum(sum[4]),.cin(co4),.carry(co5));

fa b6(.a(val1[5]),.b(val2[5]),.sum(sum[5]),.cin(co5),.carry(co6));

fa b7(.a(val1[6]),.b(val2[6]),.sum(sum[6]),.cin(co6),.carry(co7));

fa b8(.a(val1[7]),.b(val2[7]),.sum(sum[7]),.cin(co7),.carry(carry));

endmodule
///////////////////////////////////////////////////////////////////
module fs(a,b,dif,bin,bo);
input a,b ,bin;
output dif,bo;
assign dif=((~a)&(~b)&bin)|((~a)&b&(~bin))|(a&(~b)&(~bin))|(a&b&bin);
assign bo=((~a)&(~b)&bin)|((~a)&b&(~bin))|((~a)&b&bin)|(a&b&bin);

endmodule
//////////////////////////////////////////////////////////////////////
module fullsub_8bit(a,b,bin,dif,bo);
input[7:0]a;
input[7:0]b;
input bin;
output [7:0]dif;
output  bo;
wire bo1,bo2,bo3,bo4,bo5,bo6,bo7;
 
 fs fs1(.a(a[0]),.b(b[0]),.dif(dif[0]),.bin(bin),.bo(bo1));
 
 fs fs2(.a(a[1]),.b(b[1]),.dif(dif[1]),.bin(bo1),.bo(bo2));
 
 fs fs3(.a(a[2]),.b(b[2]),.dif(dif[2]),.bin(bo2),.bo(bo3));
 
 fs fs4(.a(a[3]),.b(b[3]),.dif(dif[3]),.bin(bo3),.bo(bo4));
 
 fs fs5(.a(a[4]),.b(b[4]),.dif(dif[4]),.bin(bo4),.bo(bo5));
 
 fs fs6(.a(a[5]),.b(b[5]),.dif(dif[5]),.bin(bo5),.bo(bo6));
 
 fs fs7(.a(a[6]),.b(b[6]),.dif(dif[6]),.bin(bo6),.bo(bo7));
 
 fs fs8(.a(a[7]),.b(b[7]),.dif(dif[7]),.bin(bo7),.bo(bo));
 
endmodule 
//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////
module shiftop( a, y,z);

input[7:0] a;
output reg [7:0] y;
output reg [7:0] z;
always@(a)
	begin
	y = a << 2;
	
	z = a >> 2;
	end

endmodule
//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////
module mul(a,y);
input[7:0]a;
output reg[7:0]y;
//shiftop b1( .A(a), .y(y));
always@(a)
	begin
	y = a << 2;
	
//	z = A >> 2;
	end

endmodule 
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////
module div(a,z);
input[7:0]a;
output reg[7:0]z;
//shiftop div1( .A(a), .z(z));
always@(a)
	begin
//	y = a << 2;
	
	z = a >> 2;
	end


endmodule
///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////
/*module log_op(a,b,y1,y2,y3,y4,y5);
input[7:0]a;
input[7:0]b;
output[7:0]y1;
output[7:0]y2;
output[7:0]y3;
output[7:0]y4;
output[7:0]y5;

assign y1=~a;
assign y2=~b;
assign y3=a&b;
assign y4=a|b;
assign y5=a^b;

endmodule

*/
module comp_num(a,b,cmp_a,cmp_b);
input [7:0] a;
input [7:0] b;
output [7:0]cmp_a;
output [7:0]cmp_b;

assign cmp_a=~a;
assign cmp_b=~b;
endmodule 
