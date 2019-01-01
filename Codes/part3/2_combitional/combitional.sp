* combitional
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

VinA    A		0		DC		0
*VinA	 A 		0   	Pulse	VDD  	GND 	0   	1p		1p 		1000p 		2500p

VinB    B		0		DC		1
*VinB	 B 		0   	Pulse	VDD  	GND 	0   	1p		1p 		1000p 		2500p

***** Component *****
X1		Vm		A		Ab		inverterCmos  
X2		Vm		B		Bb		inverterCmos  

*Pull Up
Mp1		y1	  	A   	Vm	    Vm		pmos	l='Lmin'	w='2*Lmin*Wp'
Mp2     F     	Bb   	y1     	y1   	pmos	l='Lmin'    w='2*Lmin*Wp'
Mp3		y2	  	B   	Vm	    Vm		pmos	l='Lmin'	w='2*Lmin*Wp'
Mp4     F     	Ab   	y2     	y2   	pmos	l='Lmin'    w='2*Lmin*Wp'

*Pull Down
Mn1	    F	   	A   	y3  	y3     	nmos	l='Lmin'	w='2*Lmin*Wn'
Mn2	    y3	   	B   	GND  	GND     nmos	l='Lmin'	w='2*Lmin*Wn'
Mn3	    F	   	Ab   	y4  	y4     	nmos	l='Lmin'	w='2*Lmin*Wn'
Mn4	    y4	   	Bb   	GND  	GND     nmos	l='Lmin'	w='2*Lmin*Wn'

* capacitor
Cf		F		0       10ff

*inverter
X3		Vm		F		W1		inverterCmos
X4		Vm		W1		W2		inverterCmos
X5		Vm		W2		W3		inverterCmos
X6		Vm		W3		out		inverterCmos

***** INVERTER
.SUBCKT inverterCmos	VDD     A 		out
Mp1		out	  	A   	VDD	    VDD		pmos	l='Lmin'	w='Lmin*Wp'
Mn1	    out	   	A   	GND  	GND     nmos	l='Lmin'	w='Lmin*Wn'
Cl		out		0       10ff
.ENDS inverterCmos

***** Type of Analysis *****
***** Transient analysis:
.tran	0.1ns     100ns   1ns

.op
.end
