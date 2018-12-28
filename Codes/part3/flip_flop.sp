* flip flop
***** Library *****
.prot
.inc '32nm_bulk.pm'
.unprot

***** Params *****
.param  +VDD = 1V
+GND = 0V
+Lmin = 32n
+Wp = 4
+Wn = 2

***** Temperature *****
.temp	25

***** Sources *****

Vsupply	Vm		0	DC	1

*VinD    D		0	DC		1
VinD	 D 		0   Pulse	VDD  	GND 	0   	1p		1p 		500p 		2500p

VinClk  clk 	0   Pulse	GND		VDD 	0   	1p 		1p 		3000p 		4000p
*V      N+  	N-  Pulse   V1  	V2  	TD  	TR  	TF  	PW  		PER
***** Component *****
X1		Vm		W3		Q		inverterCmos

***** NAND
.SUBCKT nandCmos	VDD     A       B       out
Mp1		out	  		A   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mp2     out     	B   	VDD     VDD   	pmos	l='Lmin'    w='Lmin*Wp'
Mn1	    2	   		B   	GND  	GND     nmos	l='Lmin'	w='2*Lmin*Wn'
Mn2	    out	   		A   	2  		2     	nmos	l='Lmin'	w='2*Lmin*Wn'
Cl		out			0       10ff
.ENDS nandCmos

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

.op
.end
