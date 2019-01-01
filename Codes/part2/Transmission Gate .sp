* Transmission Gate
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

Vsupply	Vm		0		DC		1

*VinD    D		0		DC		1
VinD	 D 		0   	Pulse	VDD  	GND 	500p   1p		1p 		1500p 		3000p

VinClk  clk 	0   	Pulse	GND		VDD 	0p   	1p 		1p 		3000p 		4000p
*V      N+  	N-  	Pulse   V1  	V2  	TD  	TR  	TF  	PW  		PER
***** Component *****

Xclk  	Vm     clk    clkBar	inverterCmos

Mp1		W1		clk		D		D		pmos	l='Lmin'	w='Lmin*Wp'
Mn1	    W1	   	clkBar  D  		D     	nmos	l='Lmin'	w='Lmin*Wn'
C1		W1		0       5ff
X1		Vm		W1		W2		inverterCmos

Mp2		W3		clkBar	W2		W2		pmos	l='Lmin'	w='Lmin*Wp'
Mn2	    W3	   	clk  	W2  	W2     	nmos	l='Lmin'	w='Lmin*Wn'	     
C2		W3		0       5ff
X2		Vm		W3		Q		inverterCmos

***** INVERTER
.SUBCKT inverterCmos	VDD     A 		out
Mp1		out	  	A   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn1	    out	   	A   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
Cl		out		0       5ff
.ENDS inverterCmos

***** Type of Analysis *****
***** Transient analysis:
.tran	0.1ns     100ns   1ns

***** Transition Time :
.MEASURE TRAN t_rise
+ trig V(Q) val = '0.1*VDD'  rise = 1
+ targ V(Q) val = '0.9*VDD'  rise = 1

.MEASURE TRAN t_fall
+ trig V(Q) val = '0.9*VDD'  fall = 1
+ targ V(Q) val = '0.1*VDD'  fall = 2

.MEASURE TRAN t_clk_to_Q
+ trig V(Q) val = '0.9*VDD'  rise = 1
+ targ V(Q) val = '0.9*VDD'  fall = 3
.op
.end
