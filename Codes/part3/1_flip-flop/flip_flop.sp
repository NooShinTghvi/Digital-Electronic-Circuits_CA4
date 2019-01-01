* flip flop
***** Library *****
.prot
.inc '32nm_bulk.pm'
.unprot

***** Params *****
.param  +VDD = 1V
+GND = 0V
+Lmin = 32n
+Wp = 2
+Wn = 1

***** Temperature *****
.temp	25

***** Sources *****
Vsupply	Vm		0		DC		1

*VinD    D		0		DC		1
VinD	 D 		0   	Pulse	VDD  	GND 	0   	1p		1p 		1500p 		3000p

VinClk  clk 	0   	Pulse	GND		VDD 	0   	1p 		1p 		2000p 		4000p
*V      N+  	N-  	Pulse   V1  	V2  	TD  	TR  	TF  	PW  		PER

***** Component *****
X1		Vm		W4		W2		W1		nand2input
X2		Vm		W1		clk		W2		nand2input
X3		Vm		W2		clk		W4		W3		nand3input
X4		Vm		W3		D		W4		nand2input
X5		Vm		W2		Qb		Q		nand2input
X6		Vm		W3		Q		Qb		nand2input

***** NAND 2 input
.SUBCKT nand2input	VDD     A       B       out
Mp1		out	  		A   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mp2     out     	B   	VDD     VDD   	pmos	l='Lmin'    w='Lmin*Wp'
Mn1	    2	   		B   	GND  	GND     nmos	l='Lmin'	w='2*Lmin*Wn'
Mn2	    out	   		A   	2  		2     	nmos	l='Lmin'	w='2*Lmin*Wn'
Cl		out			0       5ff
.ENDS nand2input

***** NAND 3 input
.SUBCKT nand3input	VDD     A       B       C		out
Mp1		out	  		A   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mp2     out     	B   	VDD     VDD   	pmos	l='Lmin'    w='Lmin*Wp'
Mp3     out     	C   	VDD     VDD   	pmos	l='Lmin'    w='Lmin*Wp'
Mn1	    2	   		C   	GND  	GND     nmos	l='Lmin'	w='3*Lmin*Wn'
Mn2	    3	   		B   	2  		2     	nmos	l='Lmin'	w='3*Lmin*Wn'
Mn3	    out	   		A   	3  		3     	nmos	l='Lmin'	w='3*Lmin*Wn'
Cl		out			0       5ff
.ENDS nand3input

***** Type of Analysis *****
***** Transient analysis:
.tran	0.1ns     100ns   1ns

***** Transition Time :
.MEASURE TRAN t_rise
+ trig V(Q) val = '0.1*VDD'  rise = 1
+ targ V(Q) val = '0.9*VDD'  rise = 1

.MEASURE TRAN t_fall
+ trig V(Q) val = '0.9*VDD'  fall = 1
+ targ V(Q) val = '0.1*VDD'  fall = 1

.MEASURE TRAN t_clk_to_Q
+ trig V(Q) val = '0.9*VDD'  rise = 1
+ targ V(Q) val = '0.9*VDD'  fall = 3

.op
.end
