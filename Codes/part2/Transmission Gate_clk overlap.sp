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

VinD    D		0		DC		0
*VinD	 D 		0   	Pulse	VDD  	GND 	0p   1p		1p 		1000p 		2000p

VinClk  clk 	0   	Pulse	GND		VDD 	0p   1p 	1p 		2000p 		4000p
*V      N+  	N-  	Pulse   V1  	V2  	TD  	TR  	TF  	PW  		PER
***** Component *****

Xclk  	Vm     clk    clkBar	inverters

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
***** INVERTER
.SUBCKT inverters	VDD     A 		out
Mp1		y1	  	A   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn1	    y1	   	A   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C1		y1		0       5ff

Mp2		y2	  	y1   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn2	    y2	   	y1   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C2		y2		0       5ff

Mp3		y3	  	y2   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn3	    y3	   	y2   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C3		y3		0       5ff

Mp4		y4	  	y3   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn4	    y4	   	y3   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C4		y4		0       5ff

Mp5		y5	  	y4   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn5	    y5	   	y4   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C5		y5		0       5ff

Mp6		y6	  	y5   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn6	    y6	   	y5   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C6		y6		0       5ff

Mp7		y7	  	y6   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn7	    y7	   	y6   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C7		y7		0       5ff

Mp8		y8	  	y7   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn8	    y8	   	y7   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C8		y8		0       5ff

Mp9		y9	  	y8   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn9	    y9	   	y8   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C9		y9		0       5ff

Mp10	out	  	y9   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn10	out	   	y9   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
C10		out		0       5ff
.ENDS inverters
***** Type of Analysis *****
***** Transient analysis:
.tran	0.1ns     30ns   1ns

***** Transition Time :
.MEASURE TRAN t_rise
+ trig V(Q) val = '0.1*VDD'  rise = 1
+ targ V(Q) val = '0.9*VDD'  rise = 1

.MEASURE TRAN t_fall
+ trig V(Q) val = '0.9*VDD'  fall = 1
+ targ V(Q) val = '0.1*VDD'  fall = 1

.op
.end
