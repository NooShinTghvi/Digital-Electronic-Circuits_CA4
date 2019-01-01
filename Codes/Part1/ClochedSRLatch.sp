* ClockedSRLatch
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
*VinS    S		0		DC		0
VinS	S 		0   	Pulse  	GND  	VDD 	500p   	1p		1p 		310p 		3000p

*VinR    R		0		DC		1
VinR    R 		0   	Pulse  	VDD  	GND   	0p   	1p 		1p 		2700p 		3000p

VinClk  clk 	0   	Pulse  	GND  	VDD 	0p   	1p 		1p 		2000p 		4000p
*V      N+  	N-  	Pulse   V1  	V2  	TD  	TR  	TF  	PW  		PER
***** Component *****

X1      Vm      S		clk		W1      andCmos
X2		Vm		R		clk		W2		andCmos
X3		Vm		W1		Q		Qb		norCmos
X4		Vm		W2		Qb		Q		norCmos

***** NAND
.SUBCKT nandCmos        VDD     A       B       out
Mp1		out	  	A   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mp2     out     B   	VDD     VDD   	pmos	l='Lmin'    w='Lmin*Wp'
Mn1	    2	   	B   	GND  	GND     nmos	l='Lmin'	w='2*Lmin*Wn'
Mn2	    out	   	A   	2  		2     	nmos	l='Lmin'	w='2*Lmin*Wn'
Cl		out		0       10ff
.ENDS nandCmos

***** NOR
.SUBCKT norCmos        	VDD     A       B       out
Mp1	    2	   	A   	VDD  	VDD     pmos	l='Lmin'	w='2*Lmin*Wp'
Mp2	    out	   	B   	2  		2     	pmos	l='Lmin'	w='2*Lmin*Wp'
Mn1		out	  	A   	GND	    GND		nmos	l='Lmin'	w='Lmin*Wn'
Mn2     out     B   	GND     GND   	nmos	l='Lmin'    w='Lmin*Wn'
Cl		out		0       10ff
.ENDS norCmos

***** INVERTER
.SUBCKT inverterCmos	VDD     A 		out
Mp1		out	  	A   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn1	    out	   	A   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
Cl		out		0       5ff
.ENDS inverterCmos

***** AND
.SUBCKT andCmos    VDD     A       B       out
Xnand      VDD     A       B       wire     nandCmos
Xinverter  VDD     wire    out     inverterCmos
.ENDS andCmos

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
