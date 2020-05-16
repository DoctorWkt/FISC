EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 5
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74xx:74LS161 U18
U 1 1 5E334110
P 1850 4600
F 0 "U18" H 1700 5500 50  0000 C CNN
F 1 "74HCT161" H 1650 5400 50  0000 C CNN
F 2 "Package_SO:SOIC-16W_5.3x10.2mm_P1.27mm" H 1850 4600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 1850 4600 50  0001 C CNN
F 4 "uSeq Counter" H 1850 4600 50  0001 C CNN "Description"
	1    1850 4600
	1    0    0    -1  
$EndComp
$Comp
L 74xx_IEEE:74151 U20
U 1 1 5E335F03
P 7250 1800
F 0 "U20" H 7250 2666 50  0000 C CNN
F 1 "74HCT151" H 7250 2575 50  0000 C CNN
F 2 "Package_SO:SOIC-16W_5.3x10.2mm_P1.27mm" H 7250 1800 50  0001 C CNN
F 3 "" H 7250 1800 50  0001 C CNN
F 4 "Jump Logic" H 7250 1800 50  0001 C CNN "Description"
	1    7250 1800
	1    0    0    -1  
$EndComp
$Comp
L AT27C1024:AT27C1024-70PU U25
U 1 1 5E1C5161
P 3800 2550
F 0 "U25" H 4350 2815 50  0000 C CNN
F 1 "AT27C1024-70PU" H 4350 2724 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm" H 1350 4050 50  0001 L CNN
F 3 "http://www.atmel.com/images/doc0019.pdf" H 1350 3950 50  0001 L CNN
F 4 "Decode ROM" H 1350 3850 50  0001 L CNN "Description"
F 5 "4.826" H 1350 3750 50  0001 L CNN "Height"
F 6 "Microchip" H 1350 3650 50  0001 L CNN "Manufacturer_Name"
F 7 "AT27C1024-70PU" H 1350 3550 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "556-AT27C102470PU" H 1350 3450 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=556-AT27C102470PU" H 1350 3350 50  0001 L CNN "Mouser Price/Stock"
F 10 "6962768" H 1350 3250 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/6962768" H 1350 3150 50  0001 L CNN "RS Price/Stock"
	1    3800 2550
	1    0    0    -1  
$EndComp
Entry Wire Line
	2950 1900 2850 1800
Entry Wire Line
	2950 2000 2850 1900
Entry Wire Line
	2950 2100 2850 2000
Entry Wire Line
	2950 2200 2850 2100
Entry Wire Line
	2950 2300 2850 2200
Entry Wire Line
	2950 2400 2850 2300
Entry Wire Line
	2950 2500 2850 2400
Entry Wire Line
	2950 2600 2850 2500
Wire Wire Line
	2350 1800 2600 1800
Wire Wire Line
	2350 2000 2800 2000
Wire Wire Line
	2850 2100 2350 2100
Wire Wire Line
	2350 2200 2850 2200
Wire Wire Line
	2850 2300 2350 2300
Wire Wire Line
	2350 2400 2850 2400
Wire Wire Line
	2850 2500 2350 2500
Entry Wire Line
	2950 4100 2850 4200
Entry Wire Line
	2950 4000 2850 4100
Entry Wire Line
	2950 4200 2850 4300
Entry Wire Line
	2950 4300 2850 4400
Entry Wire Line
	2950 4400 3050 4500
Entry Wire Line
	2950 4300 3050 4400
Entry Wire Line
	2950 4200 3050 4300
Entry Wire Line
	2950 4100 3050 4200
Entry Wire Line
	2950 4000 3050 4100
Entry Wire Line
	2950 3900 3050 4000
Entry Wire Line
	2950 3800 3050 3900
Entry Wire Line
	2950 3700 3050 3800
Entry Wire Line
	2950 3600 3050 3700
Entry Wire Line
	2950 3500 3050 3600
Entry Wire Line
	2950 3400 3050 3500
Entry Wire Line
	2950 3300 3050 3400
Wire Wire Line
	3050 3400 3800 3400
Wire Wire Line
	3800 3500 3050 3500
Wire Wire Line
	3050 3600 3800 3600
Wire Wire Line
	3800 3700 3050 3700
Wire Wire Line
	3050 3800 3800 3800
Wire Wire Line
	3800 3900 3050 3900
Wire Wire Line
	3050 4000 3800 4000
Wire Wire Line
	3800 4100 3050 4100
Wire Wire Line
	3050 4200 3800 4200
Wire Wire Line
	3800 4300 3050 4300
Wire Wire Line
	3050 4400 3800 4400
Wire Wire Line
	3800 4500 3050 4500
Text Label 2400 4100 0    50   ~ 0
seq0
Text Label 2400 4200 0    50   ~ 0
seq1
Text Label 2400 4300 0    50   ~ 0
seq2
Text Label 2400 4400 0    50   ~ 0
seq3
Text Label 2450 1800 0    50   ~ 0
ir0
Text Label 2450 1900 0    50   ~ 0
ir1
Text Label 2450 2000 0    50   ~ 0
ir2
Text Label 2450 2100 0    50   ~ 0
ir3
Text Label 2450 2200 0    50   ~ 0
ir4
Text Label 2450 2300 0    50   ~ 0
ir5
Text Label 2450 2400 0    50   ~ 0
ir6
Text Label 2450 2500 0    50   ~ 0
ir7
Text Label 3350 4500 0    50   ~ 0
seq0
Text Label 3350 4400 0    50   ~ 0
seq1
Text Label 3350 4300 0    50   ~ 0
seq2
Text Label 3350 4200 0    50   ~ 0
seq3
Text Label 3350 4100 0    50   ~ 0
ir0
Text Label 3350 4000 0    50   ~ 0
ir1
Text Label 3350 3900 0    50   ~ 0
ir2
Text Label 3350 3800 0    50   ~ 0
ir3
Text Label 3350 3700 0    50   ~ 0
ir4
Text Label 3350 3600 0    50   ~ 0
ir5
Text Label 3350 3500 0    50   ~ 0
ir6
Text Label 3350 3400 0    50   ~ 0
ir7
Text GLabel 3500 3000 0    50   Input ~ 0
Lo
Wire Wire Line
	3800 3000 3600 3000
Wire Wire Line
	3800 3300 3600 3300
Wire Wire Line
	3600 3300 3600 3200
Connection ~ 3600 3000
Wire Wire Line
	3600 3000 3500 3000
Wire Wire Line
	3800 3100 3600 3100
Connection ~ 3600 3100
Wire Wire Line
	3600 3100 3600 3000
Wire Wire Line
	3800 3200 3600 3200
Connection ~ 3600 3200
Wire Wire Line
	3600 3200 3600 3100
Wire Wire Line
	3800 2850 3600 2850
Wire Wire Line
	3600 2850 3600 3000
NoConn ~ 3800 2750
Text GLabel 3500 2550 0    50   Input ~ 0
Hi
Wire Wire Line
	3500 2550 3600 2550
Wire Wire Line
	3800 2650 3600 2650
Wire Wire Line
	3600 2650 3600 2550
Connection ~ 3600 2550
Wire Wire Line
	3600 2550 3800 2550
$Comp
L power:VCC #PWR0138
U 1 1 5E1DA360
P 5050 2450
F 0 "#PWR0138" H 5050 2300 50  0001 C CNN
F 1 "VCC" H 5067 2623 50  0000 C CNN
F 2 "" H 5050 2450 50  0001 C CNN
F 3 "" H 5050 2450 50  0001 C CNN
	1    5050 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 2550 5050 2550
Wire Wire Line
	5050 2550 5050 2450
$Comp
L power:GND #PWR0139
U 1 1 5E1DBB86
P 5350 2650
F 0 "#PWR0139" H 5350 2400 50  0001 C CNN
F 1 "GND" H 5355 2477 50  0000 C CNN
F 2 "" H 5350 2650 50  0001 C CNN
F 3 "" H 5350 2650 50  0001 C CNN
	1    5350 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 2650 5050 2650
Wire Wire Line
	4900 2750 5050 2750
Wire Wire Line
	5050 2750 5050 2650
Connection ~ 5050 2650
Wire Wire Line
	5050 2650 5350 2650
Text GLabel 5050 2850 2    50   Input ~ 0
Lo
Wire Wire Line
	4900 2850 5050 2850
Text Notes 1700 4550 0    50   ~ 0
 uSeq\nCounter
Text Notes 1800 2350 0    50   ~ 0
IR
Text Notes 4200 3750 0    50   ~ 0
Decode\n  ROM
$Comp
L power:VCC #PWR0140
U 1 1 5E1E3B5F
P 1850 3700
F 0 "#PWR0140" H 1850 3550 50  0001 C CNN
F 1 "VCC" H 1867 3873 50  0000 C CNN
F 2 "" H 1850 3700 50  0001 C CNN
F 3 "" H 1850 3700 50  0001 C CNN
	1    1850 3700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0141
U 1 1 5E1E46D1
P 1850 5500
F 0 "#PWR0141" H 1850 5250 50  0001 C CNN
F 1 "GND" H 1855 5327 50  0000 C CNN
F 2 "" H 1850 5500 50  0001 C CNN
F 3 "" H 1850 5500 50  0001 C CNN
	1    1850 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 5400 1850 5500
Wire Wire Line
	1850 3700 1850 3800
$Comp
L power:GND #PWR0142
U 1 1 5E1E7301
P 1850 3150
F 0 "#PWR0142" H 1850 2900 50  0001 C CNN
F 1 "GND" H 1855 2977 50  0000 C CNN
F 2 "" H 1850 3150 50  0001 C CNN
F 3 "" H 1850 3150 50  0001 C CNN
	1    1850 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 3100 1850 3150
$Comp
L power:VCC #PWR0143
U 1 1 5E1E9530
P 1850 1400
F 0 "#PWR0143" H 1850 1250 50  0001 C CNN
F 1 "VCC" H 1867 1573 50  0000 C CNN
F 2 "" H 1850 1400 50  0001 C CNN
F 3 "" H 1850 1400 50  0001 C CNN
	1    1850 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 1400 1850 1500
Wire Bus Line
	1050 750  900  750 
Text GLabel 900  750  0    50   Input ~ 0
d[0..7]
Entry Wire Line
	1050 2400 1150 2500
Entry Wire Line
	1050 2300 1150 2400
Entry Wire Line
	1050 2200 1150 2300
Entry Wire Line
	1050 2100 1150 2200
Entry Wire Line
	1050 2000 1150 2100
Entry Wire Line
	1050 1900 1150 2000
Entry Wire Line
	1050 1800 1150 1900
Text Label 1200 2500 0    50   ~ 0
d7
Text Label 1200 2400 0    50   ~ 0
d6
Text Label 1200 2300 0    50   ~ 0
d5
Text Label 1200 2200 0    50   ~ 0
d4
Text Label 1200 2100 0    50   ~ 0
d3
Text Label 1200 2000 0    50   ~ 0
d2
Text Label 1200 1900 0    50   ~ 0
d1
Text Label 1200 1800 0    50   ~ 0
d0
Text GLabel 1150 2700 0    50   Input ~ 0
IRread
Text GLabel 1150 2800 0    50   Input ~ 0
Lo
Wire Wire Line
	1150 2700 1350 2700
Wire Wire Line
	1150 2800 1350 2800
Text GLabel 1050 4100 0    50   Input ~ 0
Lo
Wire Wire Line
	1050 4100 1150 4100
Wire Wire Line
	1350 4400 1150 4400
Wire Wire Line
	1150 4400 1150 4300
Connection ~ 1150 4100
Wire Wire Line
	1150 4100 1350 4100
Wire Wire Line
	1350 4200 1150 4200
Connection ~ 1150 4200
Wire Wire Line
	1150 4200 1150 4100
Wire Wire Line
	1350 4300 1150 4300
Connection ~ 1150 4300
Wire Wire Line
	1150 4300 1150 4200
NoConn ~ 2350 4600
Text GLabel 1050 5100 0    50   Input ~ 0
~Reset
Wire Wire Line
	1050 5100 1350 5100
Text GLabel 1050 4900 0    50   Input ~ 0
Clk
Wire Wire Line
	1050 4900 1350 4900
Text GLabel 1050 4700 0    50   Input ~ 0
Hi
Wire Wire Line
	1050 4700 1150 4700
Wire Wire Line
	1350 4800 1150 4800
Wire Wire Line
	1150 4800 1150 4700
Connection ~ 1150 4700
Wire Wire Line
	1150 4700 1350 4700
Text GLabel 1150 4600 0    50   Input ~ 0
~uSreset
Wire Wire Line
	1150 4600 1350 4600
Text GLabel 5150 4500 2    50   Output ~ 0
ALUop0
Text GLabel 5150 4400 2    50   Output ~ 0
ALUop1
Text GLabel 5150 4300 2    50   Output ~ 0
ALUop2
Text GLabel 5150 4200 2    50   Output ~ 0
ALUop3
Wire Wire Line
	4900 4200 5150 4200
Wire Wire Line
	5150 4300 4900 4300
Wire Wire Line
	4900 4400 5150 4400
Wire Wire Line
	5150 4500 4900 4500
Text GLabel 5250 3000 2    50   Output ~ 0
~uSreset
Wire Wire Line
	4900 3000 5250 3000
Text GLabel 5250 4100 2    50   Output ~ 0
DbWr0
Text GLabel 5250 4000 2    50   Output ~ 0
DbWr1
Text GLabel 5250 3900 2    50   Output ~ 0
DbWr2
Text GLabel 5150 3800 2    50   Output ~ 0
AbWr0
Text GLabel 5150 3700 2    50   Output ~ 0
AbWr1
Text GLabel 5250 3600 2    50   Output ~ 0
DbRd0
Text GLabel 5250 3500 2    50   Output ~ 0
DbRd1
Text GLabel 5250 3400 2    50   Output ~ 0
DbRd2
Text GLabel 5250 3300 2    50   Output ~ 0
DbRd3
Text GLabel 5150 3200 2    50   Output ~ 0
StkOp0
Text GLabel 5150 3100 2    50   Output ~ 0
StkOp1
Wire Wire Line
	4900 3100 5150 3100
Wire Wire Line
	4900 3200 5150 3200
Wire Wire Line
	5250 3300 4900 3300
Wire Wire Line
	4900 3400 5250 3400
Wire Wire Line
	5250 3500 4900 3500
Wire Wire Line
	4900 3600 5250 3600
Wire Wire Line
	5150 3700 4900 3700
Wire Wire Line
	4900 3800 5150 3800
Wire Wire Line
	5250 3900 4900 3900
Wire Wire Line
	4900 4000 5250 4000
Wire Wire Line
	5250 4100 4900 4100
Text GLabel 6450 1700 0    50   Input ~ 0
Zout
Text GLabel 6450 1800 0    50   Input ~ 0
Nout
Text GLabel 6450 1900 0    50   Input ~ 0
NotZout
Text GLabel 6450 2000 0    50   Input ~ 0
NorZout
Text GLabel 6450 2100 0    50   Input ~ 0
ZNNout
Text GLabel 6450 2200 0    50   Input ~ 0
NNNZout
Text GLabel 6450 2300 0    50   Input ~ 0
~RXready
Text GLabel 6450 2400 0    50   Input ~ 0
~TXready
Wire Wire Line
	6450 1700 6700 1700
Wire Wire Line
	6450 1800 6700 1800
Wire Wire Line
	6450 1900 6700 1900
Wire Wire Line
	6450 2000 6700 2000
Wire Wire Line
	6450 2100 6700 2100
Wire Wire Line
	6450 2200 6700 2200
Wire Wire Line
	6450 2300 6700 2300
Wire Wire Line
	6450 2400 6700 2400
Text Notes 7200 1950 0    50   ~ 0
Jump\nLogic
NoConn ~ 7800 1450
Wire Wire Line
	2850 1900 2700 1900
Wire Wire Line
	6700 1350 2600 1350
Wire Wire Line
	2600 1350 2600 1800
Connection ~ 2600 1800
Wire Wire Line
	2600 1800 2850 1800
Wire Wire Line
	6700 1450 2700 1450
Wire Wire Line
	2700 1450 2700 1900
Connection ~ 2700 1900
Wire Wire Line
	2700 1900 2350 1900
Wire Wire Line
	2800 1550 2800 2000
Connection ~ 2800 2000
Wire Wire Line
	2800 2000 2850 2000
Wire Wire Line
	2800 1550 6700 1550
$Comp
L 74xx:74LS138 U19
U 1 1 5E2FC95F
P 9650 2550
F 0 "U19" H 9400 3250 50  0000 C CNN
F 1 "74HCT138" H 9400 3150 50  0000 C CNN
F 2 "Package_SO:SOIC-16W_5.3x10.2mm_P1.27mm" H 9650 2550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS138" H 9650 2550 50  0001 C CNN
F 4 "Databus Write Demux" H 9650 2550 50  0001 C CNN "Description"
	1    9650 2550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0144
U 1 1 5E2FF561
P 9650 3300
F 0 "#PWR0144" H 9650 3050 50  0001 C CNN
F 1 "GND" H 9655 3127 50  0000 C CNN
F 2 "" H 9650 3300 50  0001 C CNN
F 3 "" H 9650 3300 50  0001 C CNN
	1    9650 3300
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0145
U 1 1 5E30008C
P 9650 1850
F 0 "#PWR0145" H 9650 1700 50  0001 C CNN
F 1 "VCC" H 9667 2023 50  0000 C CNN
F 2 "" H 9650 1850 50  0001 C CNN
F 3 "" H 9650 1850 50  0001 C CNN
	1    9650 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 1850 9650 1950
Wire Wire Line
	9650 3250 9650 3300
Text GLabel 9000 2250 0    50   Input ~ 0
DbWr0
Text GLabel 9000 2350 0    50   Input ~ 0
DbWr1
Text GLabel 9000 2450 0    50   Input ~ 0
DbWr2
Wire Wire Line
	9000 2250 9150 2250
Wire Wire Line
	9150 2350 9000 2350
Wire Wire Line
	9000 2450 9150 2450
Text GLabel 9000 2750 0    50   Input ~ 0
Hi
Text GLabel 9000 2850 0    50   Input ~ 0
Lo
Text GLabel 9000 2950 0    50   Input ~ 0
Clk
Wire Wire Line
	9000 2750 9150 2750
Wire Wire Line
	9000 2850 9150 2850
Wire Wire Line
	9000 2950 9150 2950
Text GLabel 10450 2350 2    50   Output ~ 0
~ADhiwrite
Text GLabel 10450 2450 2    50   Output ~ 0
~ADlowrite
Text GLabel 10450 2250 2    50   Output ~ 0
~MEMwrite
Text GLabel 10450 2550 2    50   Output ~ 0
~UARTwrite
Text GLabel 10450 2650 2    50   Output ~ 0
~Awrite
Text GLabel 10450 2750 2    50   Output ~ 0
~Owrite
Wire Wire Line
	10150 2350 10450 2350
Wire Wire Line
	10450 2450 10150 2450
Wire Wire Line
	10150 2550 10450 2550
Wire Wire Line
	10450 2650 10150 2650
Wire Wire Line
	10150 2750 10450 2750
Text Notes 9750 2650 2    50   ~ 0
DbWrite\n Demux
$Comp
L 74xx:74LS139 U21
U 2 1 5E367850
P 7250 4100
F 0 "U21" H 7250 4467 50  0000 C CNN
F 1 "74HCT139" H 7250 4376 50  0000 C CNN
F 2 "Package_SO:SOIC-16W_5.3x10.2mm_P1.27mm" H 7250 4100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 7250 4100 50  0001 C CNN
F 4 "PCincr and Address Write Demux" H 7250 4100 50  0001 C CNN "Description"
	2    7250 4100
	1    0    0    -1  
$EndComp
Text GLabel 6550 4000 0    50   Input ~ 0
AbWr1
Text GLabel 6550 4100 0    50   Input ~ 0
AbWr0
Wire Wire Line
	6550 4000 6750 4000
Wire Wire Line
	6550 4100 6750 4100
Text Notes 7350 4300 2    50   ~ 0
AbWrite\nDemux
NoConn ~ 7750 4300
Text GLabel 8000 4000 2    50   Output ~ 0
~PCwrite
Text GLabel 8000 4100 2    50   Output ~ 0
~ARwrite
Text GLabel 8000 4200 2    50   Output ~ 0
~SPwrite
Wire Wire Line
	7750 4000 8000 4000
Wire Wire Line
	7750 4100 8000 4100
Wire Wire Line
	7750 4200 8000 4200
Text GLabel 6550 4300 0    50   Input ~ 0
Clk
Wire Wire Line
	6550 4300 6750 4300
$Comp
L 74xx:74LS139 U21
U 1 1 5E396375
P 7250 3200
F 0 "U21" H 7250 3567 50  0000 C CNN
F 1 "74HCT139" H 7250 3476 50  0000 C CNN
F 2 "Package_SO:SOIC-16W_5.3x10.2mm_P1.27mm" H 7250 3200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 7250 3200 50  0001 C CNN
F 4 "PCincr and Address Write Demux" H 7250 3200 50  0001 C CNN "Description"
	1    7250 3200
	1    0    0    -1  
$EndComp
Text GLabel 6500 3400 0    50   Input ~ 0
Clk
Text GLabel 6500 3100 0    50   Input ~ 0
StkOp1
Text GLabel 6500 3200 0    50   Input ~ 0
StkOp0
Wire Wire Line
	6500 3100 6750 3100
Wire Wire Line
	6500 3200 6750 3200
Wire Wire Line
	6500 3400 6750 3400
$Comp
L 74xx:74LS154 U22
U 1 1 5E3AA002
P 3550 6000
F 0 "U22" H 3400 7100 50  0000 C CNN
F 1 "74HCT154" H 3350 7000 50  0000 C CNN
F 2 "Package_SO:SOIC-24W_7.5x15.4mm_P1.27mm" H 3550 6000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS154" H 3550 6000 50  0001 C CNN
F 4 "Databus Read Demux" H 3550 6000 50  0001 C CNN "Description"
	1    3550 6000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0146
U 1 1 5E3B8BFE
P 3550 4900
F 0 "#PWR0146" H 3550 4750 50  0001 C CNN
F 1 "VCC" H 3567 5073 50  0000 C CNN
F 2 "" H 3550 4900 50  0001 C CNN
F 3 "" H 3550 4900 50  0001 C CNN
	1    3550 4900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0147
U 1 1 5E3B996E
P 3550 7250
F 0 "#PWR0147" H 3550 7000 50  0001 C CNN
F 1 "GND" H 3555 7077 50  0000 C CNN
F 2 "" H 3550 7250 50  0001 C CNN
F 3 "" H 3550 7250 50  0001 C CNN
	1    3550 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 5000 3550 4900
Wire Wire Line
	3550 7100 3550 7250
Text GLabel 2850 5300 0    50   Input ~ 0
DbRd0
Text GLabel 2850 5400 0    50   Input ~ 0
DbRd1
Text GLabel 2850 5500 0    50   Input ~ 0
DbRd2
Text GLabel 2850 5600 0    50   Input ~ 0
DbRd3
Wire Wire Line
	2850 5300 3050 5300
Wire Wire Line
	3050 5400 2850 5400
Wire Wire Line
	2850 5500 3050 5500
Wire Wire Line
	3050 5600 2850 5600
Text Notes 7350 3350 2    50   ~ 0
PC\nIncrement
Text Notes 3600 6300 2    50   ~ 0
Databus\n Read\nDemux
Text GLabel 2850 5900 0    50   Input ~ 0
Clk
Wire Wire Line
	3050 5900 3000 5900
Wire Wire Line
	3050 5800 3000 5800
Wire Wire Line
	3000 5800 3000 5900
Connection ~ 3000 5900
Wire Wire Line
	3000 5900 2850 5900
NoConn ~ 4050 5300
Text GLabel 7900 2150 2    50   Output ~ 0
~PCread
Text GLabel 7450 5300 2    50   Output ~ 0
ARhiread
Text GLabel 7450 5400 2    50   Output ~ 0
ARloread
Text GLabel 4350 5800 2    50   Output ~ 0
~SPhiread
Text GLabel 4350 5900 2    50   Output ~ 0
~SPloread
Text GLabel 7450 5500 2    50   Output ~ 0
Aread
Text GLabel 7450 5600 2    50   Output ~ 0
Bread
Text GLabel 7450 5700 2    50   Output ~ 0
IRread
Text GLabel 4350 6300 2    50   Output ~ 0
~MEMread
Text GLabel 7450 5800 2    50   Output ~ 0
Carryread
Text GLabel 4350 6500 2    50   Output ~ 0
~UARTread
Text GLabel 4350 5500 2    50   Output ~ 0
~Jmpena
NoConn ~ 4050 6600
NoConn ~ 4050 6700
NoConn ~ 4050 6800
Text GLabel 6450 1250 0    50   Input ~ 0
~Jmpena
Wire Wire Line
	6450 1250 6700 1250
Wire Wire Line
	7800 2150 7900 2150
NoConn ~ 4050 5400
Wire Wire Line
	4050 5500 4350 5500
Wire Wire Line
	4350 5800 4050 5800
Wire Wire Line
	4050 5900 4350 5900
Wire Wire Line
	4050 6300 4350 6300
Wire Wire Line
	4050 6500 4350 6500
Text GLabel 8000 3400 2    50   Output ~ 0
~PCincr
NoConn ~ 7750 3100
NoConn ~ 7750 3300
Wire Wire Line
	7750 3400 8000 3400
NoConn ~ 7750 3200
Wire Wire Line
	1350 2500 1150 2500
Wire Wire Line
	1150 2400 1350 2400
Wire Wire Line
	1350 2300 1150 2300
Wire Wire Line
	1150 2200 1350 2200
Wire Wire Line
	1350 2100 1150 2100
Wire Wire Line
	1150 2000 1350 2000
Wire Wire Line
	1350 1900 1150 1900
Wire Wire Line
	1150 1800 1350 1800
Entry Wire Line
	1050 1700 1150 1800
$Comp
L 74xx:74HCT574 U17
U 1 1 5E333A13
P 1850 2300
F 0 "U17" H 1650 3200 50  0000 C CNN
F 1 "74HCT574" H 1600 3100 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 1850 2300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT574" H 1850 2300 50  0001 C CNN
F 4 "IR" H 1850 2300 50  0001 C CNN "Description"
	1    1850 2300
	1    0    0    -1  
$EndComp
Text Notes 650  900  0    50   ~ 0
Data Bus
NoConn ~ 10150 2850
NoConn ~ 10150 2950
Wire Wire Line
	10150 2250 10450 2250
$Comp
L 74xx:74HCT240 U4
U 1 1 5EBEFB88
P 6450 5800
F 0 "U4" H 6300 6750 50  0000 C CNN
F 1 "74HCT240" H 6200 6650 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 6450 5800 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT240.pdf" H 6450 5800 50  0001 C CNN
F 4 "Inverter" H 6450 5800 50  0001 C CNN "Description"
	1    6450 5800
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 5EBF5F99
P 6450 4800
F 0 "#PWR01" H 6450 4650 50  0001 C CNN
F 1 "VCC" H 6467 4973 50  0000 C CNN
F 2 "" H 6450 4800 50  0001 C CNN
F 3 "" H 6450 4800 50  0001 C CNN
	1    6450 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 4800 6450 5000
$Comp
L power:GND #PWR02
U 1 1 5EC00C7B
P 6450 6800
F 0 "#PWR02" H 6450 6550 50  0001 C CNN
F 1 "GND" H 6455 6627 50  0000 C CNN
F 2 "" H 6450 6800 50  0001 C CNN
F 3 "" H 6450 6800 50  0001 C CNN
	1    6450 6800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 6600 6450 6700
Wire Wire Line
	6450 6700 5850 6700
Wire Wire Line
	5850 6700 5850 6300
Wire Wire Line
	5850 6200 5950 6200
Connection ~ 6450 6700
Wire Wire Line
	6450 6700 6450 6800
Wire Wire Line
	5950 6300 5850 6300
Connection ~ 5850 6300
Wire Wire Line
	5850 6300 5850 6200
Wire Wire Line
	6950 5300 7450 5300
Wire Wire Line
	6950 5400 7450 5400
Wire Wire Line
	6950 5500 7450 5500
Wire Wire Line
	6950 5600 7450 5600
Wire Wire Line
	6950 5700 7450 5700
Wire Wire Line
	6950 5800 7450 5800
Wire Wire Line
	5050 5600 5050 5300
Wire Wire Line
	5050 5300 5950 5300
Wire Wire Line
	5150 5700 5150 5400
Wire Wire Line
	5150 5400 5950 5400
Wire Wire Line
	5250 6000 5250 5500
Wire Wire Line
	5250 5500 5950 5500
Wire Wire Line
	5350 6100 5350 5600
Wire Wire Line
	5350 5600 5950 5600
Wire Wire Line
	5450 6200 5450 5700
Wire Wire Line
	5450 5700 5950 5700
Wire Wire Line
	5550 5800 5950 5800
Text GLabel 7450 5900 2    50   Output ~ 0
~Clkbar
Wire Wire Line
	6950 5900 7450 5900
Text GLabel 5850 5900 0    50   Input ~ 0
Clk
Wire Wire Line
	5950 5900 5850 5900
Text GLabel 5600 6700 0    50   Input ~ 0
RAMena
Wire Wire Line
	5700 6000 5700 6700
Wire Wire Line
	5700 6700 5600 6700
Wire Wire Line
	5700 6000 5950 6000
Text GLabel 7450 6000 2    50   Output ~ 0
~RAMena
Wire Wire Line
	6950 6000 7450 6000
Wire Wire Line
	4050 6400 5550 6400
Wire Wire Line
	5550 5800 5550 6400
Wire Wire Line
	4050 6200 5450 6200
Wire Wire Line
	4050 6100 5350 6100
Wire Wire Line
	4050 6000 5250 6000
Wire Wire Line
	4050 5700 5150 5700
Wire Wire Line
	4050 5600 5050 5600
Text Notes 10350 3050 0    50   ~ 0
Outputs are high\nuntil Clk goes low
Text Notes 6300 3700 0    50   ~ 0
Outputs are high\nuntil Clk goes low
Text Notes 2450 6150 0    50   ~ 0
Outputs are high\nuntil Clk goes low
Text Notes 6450 1150 0    50   ~ 0
~PCread\nhigh until\n~Jmpena\ngoes low
Text GLabel 2650 3500 0    50   Input ~ 0
seq[0..3]
Wire Bus Line
	2650 3500 2750 3500
Entry Wire Line
	2650 4100 2750 4000
Entry Wire Line
	2650 4200 2750 4100
Entry Wire Line
	2650 4300 2750 4200
Entry Wire Line
	2650 4400 2750 4300
Wire Wire Line
	2350 4400 2850 4400
Wire Wire Line
	2350 4100 2850 4100
Wire Wire Line
	2350 4200 2850 4200
Wire Wire Line
	2350 4300 2850 4300
Wire Bus Line
	2750 3500 2750 4300
Wire Bus Line
	1050 750  1050 2400
Wire Bus Line
	2950 1900 2950 4400
Text Notes 7100 7000 0    50   ~ 0
The uSeq counter along with the IR's value look up a microinstruction in the\nDecode ROM. These 16 bits are then decoded by the various demuxes\nto produce the actual control lines. The Jump Logic takes the status output\nfrom the ALU plus some of the IT bits to determine\nif the PC's value should be loaded (i.e. to jump the PC's value).
Text Notes 7000 5200 0    50   ~ 0
The '240 is simply eight inverters to get the active level\nright for seven control lines. One other inverter creates the\ninverted clock signal.
$EndSCHEMATC
