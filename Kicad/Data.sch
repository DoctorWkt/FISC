EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 5
Title "FISC TTL CPU"
Date "2020-05-21"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74xx:74HCT574 U11
U 1 1 5E1BFD13
P 1850 2200
F 0 "U11" H 1650 3100 50  0000 C CNN
F 1 "74HCT574" H 1600 3000 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 1850 2200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT574" H 1850 2200 50  0001 C CNN
F 4 "Areg" H 1850 2200 50  0001 C CNN "Description"
	1    1850 2200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT574 U12
U 1 1 5E1C1EF3
P 1850 4500
F 0 "U12" H 1650 5400 50  0000 C CNN
F 1 "74HCT574" H 1600 5300 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 1850 4500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT574" H 1850 4500 50  0001 C CNN
F 4 "Breg" H 1850 4500 50  0001 C CNN "Description"
	1    1850 4500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT574 U13
U 1 1 5E1C2EF0
P 4650 4650
F 0 "U13" H 4300 5450 50  0000 C CNN
F 1 "74HCT574" H 4300 5350 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 4650 4650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT574" H 4650 4650 50  0001 C CNN
F 4 "Carry" H 4650 4650 50  0001 C CNN "Description"
	1    4650 4650
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT574 U14
U 1 1 5E1C4341
P 7350 1850
F 0 "U14" H 7150 2750 50  0000 C CNN
F 1 "74HCT574" H 7100 2650 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 7350 1850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT574" H 7350 1850 50  0001 C CNN
F 4 "Oreg" H 7350 1850 50  0001 C CNN "Description"
	1    7350 1850
	1    0    0    -1  
$EndComp
$Comp
L MC27C322:M27C322-100F1 U23
U 1 1 5E1C01D4
P 4050 1150
F 0 "U23" H 4650 1415 50  0000 C CNN
F 1 "M27C322-100F1" H 4650 1324 50  0000 C CNN
F 2 "Package_DIP:DIP-42_W15.24mm" H 1050 1400 50  0001 L CNN
F 3 "https://componentsearchengine.com/Datasheets/1/M27C322-100F1.pdf" H 1050 1300 50  0001 L CNN
F 4 "ALU" H 1050 1200 50  0001 L CNN "Description"
F 5 "5.71" H 1050 1100 50  0001 L CNN "Height"
F 6 "STMicroelectronics" H 1050 1000 50  0001 L CNN "Manufacturer_Name"
F 7 "M27C322-100F1" H 1050 900 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "511-M27C322-10F" H 1050 800 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=511-M27C322-10F" H 1050 700 50  0001 L CNN "Mouser Price/Stock"
F 10 "4151455" H 1050 600 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/4151455" H 1050 500 50  0001 L CNN "RS Price/Stock"
	1    4050 1150
	1    0    0    -1  
$EndComp
$Comp
L UM245R:UM245R U24
U 1 1 5E1C109C
P 8800 1350
F 0 "U24" H 9400 1615 50  0000 C CNN
F 1 "UM245R" H 9400 1524 50  0000 C CNN
F 2 "Package_DIP:DIP-24_W15.24mm_Socket" H 10900 1050 50  0001 L CNN
F 3 "http://www.ftdichip.com/Support/Documents/DataSheets/Modules/DS_UM245R.pdf" H 10900 950 50  0001 L CNN
F 4 "UART" H 10900 850 50  0001 L CNN "Description"
F 5 "10.5" H 10900 750 50  0001 L CNN "Height"
F 6 "FTDI Chip" H 10900 650 50  0001 L CNN "Manufacturer_Name"
F 7 "UM245R" H 10900 550 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "895-UM245R" H 10900 450 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=895-UM245R" H 10900 350 50  0001 L CNN "Mouser Price/Stock"
F 10 "0406584" H 10900 250 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/0406584" H 10900 150 50  0001 L CNN "RS Price/Stock"
F 12 "70069413" H 10900 50  50  0001 L CNN "Allied_Number"
F 13 "http://www.alliedelec.com/ftdi-um245r/70069413/" H 10900 -50 50  0001 L CNN "Allied Price/Stock"
	1    8800 1350
	1    0    0    -1  
$EndComp
Wire Bus Line
	850  700  2750 700 
Text GLabel 10550 700  2    50   Input ~ 0
d[0..7]
Entry Wire Line
	850  1700 950  1800
Entry Wire Line
	850  1600 950  1700
Entry Wire Line
	850  1800 950  1900
Entry Wire Line
	850  2000 950  2100
Entry Wire Line
	850  2200 950  2300
Entry Wire Line
	850  2300 950  2400
Wire Wire Line
	1350 1700 950  1700
Wire Wire Line
	1350 1800 950  1800
Wire Wire Line
	1350 1900 950  1900
Wire Wire Line
	1350 2100 950  2100
Wire Wire Line
	1350 2300 950  2300
Wire Wire Line
	1350 2400 950  2400
Entry Wire Line
	850  1900 950  2000
Entry Wire Line
	850  2100 950  2200
Wire Wire Line
	950  2000 1350 2000
Wire Wire Line
	950  2200 1350 2200
Text Label 1150 1700 0    50   ~ 0
d0
Text Label 1150 1800 0    50   ~ 0
d1
Text Label 1150 1900 0    50   ~ 0
d2
Text Label 1150 2000 0    50   ~ 0
d3
Text Label 1150 2100 0    50   ~ 0
d4
Text Label 1150 2200 0    50   ~ 0
d5
Text Label 1150 2300 0    50   ~ 0
d6
Text Label 1150 2400 0    50   ~ 0
d7
Entry Wire Line
	2750 1600 2650 1700
Entry Wire Line
	2750 1700 2650 1800
Entry Wire Line
	2750 1800 2650 1900
Entry Wire Line
	2750 1900 2650 2000
Entry Wire Line
	2750 2000 2650 2100
Entry Wire Line
	2750 2100 2650 2200
Entry Wire Line
	2750 2200 2650 2300
Entry Wire Line
	2750 2300 2650 2400
Wire Wire Line
	2350 1700 2650 1700
Wire Wire Line
	2650 1800 2350 1800
Wire Wire Line
	2350 1900 2650 1900
Wire Wire Line
	2650 2000 2350 2000
Wire Wire Line
	2350 2100 2650 2100
Wire Wire Line
	2650 2200 2350 2200
Wire Wire Line
	2350 2300 2650 2300
Wire Wire Line
	2650 2400 2350 2400
Text Label 2400 1700 0    50   ~ 0
d0
Text Label 2400 1800 0    50   ~ 0
d1
Text Label 2400 1900 0    50   ~ 0
d2
Text Label 2400 2000 0    50   ~ 0
d3
Text Label 2400 2100 0    50   ~ 0
d4
Text Label 2400 2200 0    50   ~ 0
d5
Text Label 2400 2300 0    50   ~ 0
d6
Text Label 2400 2400 0    50   ~ 0
d7
Text Notes 1750 2150 0    50   ~ 0
Areg
Text Notes 4550 4600 0    50   ~ 0
Carry
Entry Wire Line
	850  3900 950  4000
Entry Wire Line
	850  4000 950  4100
Entry Wire Line
	850  4100 950  4200
Entry Wire Line
	850  4200 950  4300
Entry Wire Line
	850  4300 950  4400
Entry Wire Line
	850  4400 950  4500
Entry Wire Line
	850  4500 950  4600
Entry Wire Line
	850  4600 950  4700
Wire Wire Line
	950  4000 1350 4000
Wire Wire Line
	1350 4100 950  4100
Wire Wire Line
	950  4200 1350 4200
Wire Wire Line
	1350 4300 950  4300
Wire Wire Line
	950  4400 1350 4400
Wire Wire Line
	1350 4500 950  4500
Wire Wire Line
	950  4600 1350 4600
Wire Wire Line
	1350 4700 950  4700
Wire Wire Line
	3100 2550 4050 2550
Wire Wire Line
	3100 2650 4050 2650
Wire Wire Line
	4050 2750 3100 2750
Wire Wire Line
	3100 2850 4050 2850
Wire Wire Line
	4050 2950 3100 2950
Wire Wire Line
	3100 3050 4050 3050
Wire Wire Line
	4050 3150 3100 3150
Wire Wire Line
	3100 2450 4050 2450
Text Label 3800 3150 0    50   ~ 0
b0
Text Label 3800 3050 0    50   ~ 0
b1
Text Label 3800 2950 0    50   ~ 0
b2
Text Label 3800 2850 0    50   ~ 0
b3
Text Label 3800 2750 0    50   ~ 0
b4
Text Label 3800 2650 0    50   ~ 0
b5
Text Label 3800 2550 0    50   ~ 0
b6
Text Label 3800 2450 0    50   ~ 0
b7
Entry Wire Line
	3000 4100 2900 4200
Entry Wire Line
	3000 4200 2900 4300
Entry Wire Line
	3000 4300 2900 4400
Entry Wire Line
	3000 4400 2900 4500
Entry Wire Line
	3000 4500 2900 4600
Entry Wire Line
	3000 4600 2900 4700
Entry Wire Line
	3000 3900 2900 4000
Wire Wire Line
	2350 4000 2900 4000
Wire Wire Line
	2900 4100 2350 4100
Wire Wire Line
	2350 4200 2900 4200
Wire Wire Line
	2900 4300 2350 4300
Wire Wire Line
	2350 4400 2900 4400
Wire Wire Line
	2900 4500 2350 4500
Wire Wire Line
	2350 4600 2900 4600
Entry Wire Line
	3000 4000 2900 4100
Wire Wire Line
	2350 4700 2900 4700
Text Label 2400 4000 0    50   ~ 0
b0
Text Label 2400 4100 0    50   ~ 0
b1
Text Label 2400 4200 0    50   ~ 0
b2
Text Label 2400 4300 0    50   ~ 0
b3
Text Label 2400 4400 0    50   ~ 0
b4
Text Label 2400 4500 0    50   ~ 0
b5
Text Label 2400 4600 0    50   ~ 0
b6
Text Label 2400 4700 0    50   ~ 0
b7
Entry Wire Line
	3200 2250 3300 2350
Entry Wire Line
	3200 2150 3300 2250
Entry Wire Line
	3200 1950 3300 2050
Entry Wire Line
	3200 1850 3300 1950
Entry Wire Line
	3200 1750 3300 1850
Entry Wire Line
	3200 1650 3300 1750
Entry Wire Line
	3200 1550 3300 1650
Wire Wire Line
	3300 1650 4050 1650
Wire Wire Line
	3300 1850 4050 1850
Wire Wire Line
	3300 2050 4050 2050
Entry Wire Line
	3200 2050 3300 2150
Wire Wire Line
	3300 2150 4050 2150
Wire Wire Line
	3300 2350 4050 2350
Text Label 3800 2350 0    50   ~ 0
d0
Text Label 3800 2250 0    50   ~ 0
d1
Text Label 3800 2150 0    50   ~ 0
d2
Text Label 3800 2050 0    50   ~ 0
d3
Text Label 3800 1950 0    50   ~ 0
d4
Text Label 3800 1850 0    50   ~ 0
d5
Text Label 3800 1750 0    50   ~ 0
d6
Text Label 3800 1650 0    50   ~ 0
d7
Text GLabel 5300 4150 2    50   Output ~ 0
Cin
Wire Wire Line
	5150 4150 5300 4150
Text GLabel 3750 1150 0    50   Input ~ 0
Cin
NoConn ~ 5150 4250
NoConn ~ 5150 4350
NoConn ~ 5150 4450
NoConn ~ 5150 4550
NoConn ~ 5150 4650
NoConn ~ 5150 4750
NoConn ~ 5150 4850
Text GLabel 4050 4250 0    50   Input ~ 0
Lo
Text GLabel 4050 4350 0    50   Input ~ 0
Lo
Text GLabel 4050 4450 0    50   Input ~ 0
Lo
Text GLabel 4050 4550 0    50   Input ~ 0
Lo
Text GLabel 4050 4650 0    50   Input ~ 0
Lo
Text GLabel 4050 4750 0    50   Input ~ 0
Lo
Text GLabel 4050 4850 0    50   Input ~ 0
Lo
Wire Wire Line
	4050 4250 4150 4250
Wire Wire Line
	4050 4350 4150 4350
Wire Wire Line
	4050 4450 4150 4450
Wire Wire Line
	4050 4550 4150 4550
Wire Wire Line
	4050 4650 4150 4650
Wire Wire Line
	4050 4750 4150 4750
Wire Wire Line
	4050 4850 4150 4850
Text Label 6550 1350 0    50   ~ 0
alu0
Text Label 6550 1450 0    50   ~ 0
alu1
Text Label 6550 1550 0    50   ~ 0
alu2
Text Label 6550 1650 0    50   ~ 0
alu3
Text Label 6550 1750 0    50   ~ 0
alu4
Text Label 6550 1850 0    50   ~ 0
alu5
Text Label 6550 1950 0    50   ~ 0
alu6
Text Label 6550 2050 0    50   ~ 0
alu7
Text Label 5400 2450 0    50   ~ 0
alu7
Text Label 5400 2550 0    50   ~ 0
alu6
Text Label 5400 2650 0    50   ~ 0
alu5
Text Label 5400 2750 0    50   ~ 0
alu4
Text Label 5400 2850 0    50   ~ 0
alu3
Text Label 5400 2950 0    50   ~ 0
alu2
Text Label 5400 3050 0    50   ~ 0
alu1
Text Label 5400 3150 0    50   ~ 0
alu0
Text GLabel 5600 2350 2    50   Output ~ 0
Cout
Wire Wire Line
	5250 2350 5600 2350
Text GLabel 4050 4150 0    50   Input ~ 0
Cout
Wire Wire Line
	4050 4150 4150 4150
Connection ~ 8300 700 
Wire Bus Line
	8300 700  10550 700 
Entry Wire Line
	8300 1450 8200 1550
Entry Wire Line
	8300 1350 8200 1450
Entry Wire Line
	8300 1250 8200 1350
Entry Wire Line
	8300 1950 8200 2050
Entry Wire Line
	8300 1850 8200 1950
Entry Wire Line
	8300 1750 8200 1850
Entry Wire Line
	8300 1650 8200 1750
Entry Wire Line
	8300 1550 8200 1650
Entry Wire Line
	8300 1850 8400 1950
Entry Wire Line
	8300 1750 8400 1850
Entry Wire Line
	8300 1650 8400 1750
Entry Wire Line
	8300 1550 8400 1650
Entry Wire Line
	8300 1450 8400 1550
Entry Wire Line
	8300 1350 8400 1450
Entry Wire Line
	8300 1250 8400 1350
Entry Wire Line
	8300 1950 8400 2050
Wire Wire Line
	8400 1350 8800 1350
Wire Wire Line
	8800 1450 8400 1450
Wire Wire Line
	8400 1550 8800 1550
Wire Wire Line
	8400 1650 8800 1650
Wire Wire Line
	8400 1750 8800 1750
Wire Wire Line
	8800 1850 8400 1850
Wire Wire Line
	8400 1950 8800 1950
Wire Wire Line
	8800 2050 8400 2050
Text Label 8550 1350 0    50   ~ 0
d0
Text Label 8550 1450 0    50   ~ 0
d1
Text Label 8550 1550 0    50   ~ 0
d2
Text Label 8550 1650 0    50   ~ 0
d3
Text Label 8550 1750 0    50   ~ 0
d4
Text Label 8550 1850 0    50   ~ 0
d5
Text Label 8550 1950 0    50   ~ 0
d6
Text Label 8550 2050 0    50   ~ 0
d7
Text Label 7900 1350 0    50   ~ 0
d0
Text Label 7900 1450 0    50   ~ 0
d1
Text Label 7900 1550 0    50   ~ 0
d2
Text Label 7900 1650 0    50   ~ 0
d3
Text Label 7900 1750 0    50   ~ 0
d4
Text Label 7900 1850 0    50   ~ 0
d5
Text Label 7900 1950 0    50   ~ 0
d6
Text Label 7900 2050 0    50   ~ 0
d7
Text Notes 9300 1650 0    50   ~ 0
UART
Text Notes 7250 1750 0    50   ~ 0
Oreg
Text Notes 4600 2250 0    50   ~ 0
ALU\n
Text GLabel 1250 2600 0    50   Input ~ 0
Aread
Text GLabel 1250 2700 0    50   Input ~ 0
~Awrite
Wire Wire Line
	1250 2600 1350 2600
Wire Wire Line
	1250 2700 1350 2700
Text Notes 1800 4450 0    50   ~ 0
Breg
Text GLabel 1200 4900 0    50   Input ~ 0
Bread
Text GLabel 1200 5000 0    50   Input ~ 0
Lo
Wire Wire Line
	1200 4900 1350 4900
Wire Wire Line
	1200 5000 1350 5000
Text GLabel 4050 5050 0    50   Input ~ 0
Carryread
Text GLabel 4050 5150 0    50   Input ~ 0
Lo
Text GLabel 3750 1550 0    50   Input ~ 0
ALUop0
Text GLabel 3750 1450 0    50   Input ~ 0
ALUop1
Text GLabel 3750 1350 0    50   Input ~ 0
ALUop2
Text GLabel 3750 1250 0    50   Input ~ 0
ALUop3
Wire Wire Line
	3750 1250 4050 1250
Wire Wire Line
	3750 1350 4050 1350
Wire Wire Line
	3750 1450 4050 1450
Wire Wire Line
	3750 1550 4050 1550
Text GLabel 6750 2350 0    50   Input ~ 0
~Owrite
Wire Wire Line
	6750 2350 6850 2350
Text GLabel 6750 2250 0    50   Input ~ 0
~Clkbar
Wire Wire Line
	6750 2250 6850 2250
Wire Wire Line
	4050 5050 4150 5050
Wire Wire Line
	4050 5150 4150 5150
$Comp
L power:VCC #PWR0121
U 1 1 5E2027E0
P 5350 1050
F 0 "#PWR0121" H 5350 900 50  0001 C CNN
F 1 "VCC" H 5367 1223 50  0000 C CNN
F 2 "" H 5350 1050 50  0001 C CNN
F 3 "" H 5350 1050 50  0001 C CNN
	1    5350 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 1150 5350 1150
Wire Wire Line
	5350 1150 5350 1050
$Comp
L power:GND #PWR0122
U 1 1 5E20A7D4
P 5750 1350
F 0 "#PWR0122" H 5750 1100 50  0001 C CNN
F 1 "GND" H 5755 1177 50  0000 C CNN
F 2 "" H 5750 1350 50  0001 C CNN
F 3 "" H 5750 1350 50  0001 C CNN
	1    5750 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 1250 5750 1250
Wire Wire Line
	5750 1250 5750 1350
Wire Wire Line
	5250 1350 5750 1350
Connection ~ 5750 1350
Text GLabel 5450 1450 2    50   Input ~ 0
Lo
Wire Wire Line
	5250 1450 5300 1450
Wire Wire Line
	5250 1550 5300 1550
Wire Wire Line
	5300 1550 5300 1450
Connection ~ 5300 1450
Wire Wire Line
	5300 1450 5450 1450
NoConn ~ 5250 1650
Text GLabel 5600 2250 2    50   Output ~ 0
Zout
Text GLabel 5600 2150 2    50   Output ~ 0
Nout
Text GLabel 5500 2050 2    50   Output ~ 0
NotZout
Text GLabel 5500 1950 2    50   Output ~ 0
NorZout
Text GLabel 5500 1850 2    50   Output ~ 0
ZNNout
Text GLabel 5450 1750 2    50   Output ~ 0
NNNZout
Wire Wire Line
	5250 2250 5600 2250
Wire Wire Line
	5600 2150 5250 2150
Wire Wire Line
	5250 2050 5500 2050
Wire Wire Line
	5500 1950 5250 1950
Wire Wire Line
	5250 1850 5500 1850
Wire Wire Line
	5450 1750 5250 1750
Wire Wire Line
	3750 1150 4050 1150
$Comp
L power:VCC #PWR0123
U 1 1 5E26DC0D
P 10200 1250
F 0 "#PWR0123" H 10200 1100 50  0001 C CNN
F 1 "VCC" H 10217 1423 50  0000 C CNN
F 2 "" H 10200 1250 50  0001 C CNN
F 3 "" H 10200 1250 50  0001 C CNN
	1    10200 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 1450 10200 1450
Wire Wire Line
	10200 1450 10200 1350
Wire Wire Line
	10000 1350 10200 1350
Connection ~ 10200 1350
Wire Wire Line
	10200 1350 10200 1250
NoConn ~ 10000 1550
NoConn ~ 10000 1650
Text GLabel 10250 1750 2    50   Output ~ 0
~RXready
Text GLabel 10250 1850 2    50   Output ~ 0
~TXready
NoConn ~ 10000 1950
NoConn ~ 10000 2050
NoConn ~ 10000 2150
NoConn ~ 10000 2250
NoConn ~ 10000 2350
$Comp
L power:GND #PWR0124
U 1 1 5E2AC612
P 10200 2550
F 0 "#PWR0124" H 10200 2300 50  0001 C CNN
F 1 "GND" H 10205 2377 50  0000 C CNN
F 2 "" H 10200 2550 50  0001 C CNN
F 3 "" H 10200 2550 50  0001 C CNN
	1    10200 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 2450 10200 2450
Wire Wire Line
	10200 2450 10200 2550
Wire Wire Line
	10000 1750 10250 1750
Wire Wire Line
	10000 1850 10250 1850
Text GLabel 8750 2150 0    50   Input ~ 0
~UARTread
Text GLabel 8750 2250 0    50   Input ~ 0
~UARTwrite
Wire Wire Line
	8750 2150 8800 2150
Wire Wire Line
	8750 2250 8800 2250
NoConn ~ 8800 2350
$Comp
L power:GND #PWR0125
U 1 1 5E2D8426
P 8700 2550
F 0 "#PWR0125" H 8700 2300 50  0001 C CNN
F 1 "GND" H 8705 2377 50  0000 C CNN
F 2 "" H 8700 2550 50  0001 C CNN
F 3 "" H 8700 2550 50  0001 C CNN
	1    8700 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 2550 8700 2450
Wire Wire Line
	8700 2450 8800 2450
$Comp
L power:VCC #PWR0126
U 1 1 5E2E3CEA
P 4650 3750
F 0 "#PWR0126" H 4650 3600 50  0001 C CNN
F 1 "VCC" H 4667 3923 50  0000 C CNN
F 2 "" H 4650 3750 50  0001 C CNN
F 3 "" H 4650 3750 50  0001 C CNN
	1    4650 3750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0127
U 1 1 5E2E433E
P 4650 5550
F 0 "#PWR0127" H 4650 5300 50  0001 C CNN
F 1 "GND" H 4655 5377 50  0000 C CNN
F 2 "" H 4650 5550 50  0001 C CNN
F 3 "" H 4650 5550 50  0001 C CNN
	1    4650 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 3750 4650 3850
Wire Wire Line
	4650 5450 4650 5550
$Comp
L power:VCC #PWR0128
U 1 1 5E2F54E5
P 1850 1300
F 0 "#PWR0128" H 1850 1150 50  0001 C CNN
F 1 "VCC" H 1867 1473 50  0000 C CNN
F 2 "" H 1850 1300 50  0001 C CNN
F 3 "" H 1850 1300 50  0001 C CNN
	1    1850 1300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0129
U 1 1 5E2F5B4D
P 1850 3150
F 0 "#PWR0129" H 1850 2900 50  0001 C CNN
F 1 "GND" H 1855 2977 50  0000 C CNN
F 2 "" H 1850 3150 50  0001 C CNN
F 3 "" H 1850 3150 50  0001 C CNN
	1    1850 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 1300 1850 1400
Wire Wire Line
	1850 3000 1850 3150
$Comp
L power:VCC #PWR0130
U 1 1 5E3071DC
P 1850 3600
F 0 "#PWR0130" H 1850 3450 50  0001 C CNN
F 1 "VCC" H 1867 3773 50  0000 C CNN
F 2 "" H 1850 3600 50  0001 C CNN
F 3 "" H 1850 3600 50  0001 C CNN
	1    1850 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0131
U 1 1 5E307EBE
P 1850 5400
F 0 "#PWR0131" H 1850 5150 50  0001 C CNN
F 1 "GND" H 1855 5227 50  0000 C CNN
F 2 "" H 1850 5400 50  0001 C CNN
F 3 "" H 1850 5400 50  0001 C CNN
	1    1850 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 3600 1850 3700
Wire Wire Line
	1850 5300 1850 5400
$Comp
L power:VCC #PWR0132
U 1 1 5E318A92
P 7350 950
F 0 "#PWR0132" H 7350 800 50  0001 C CNN
F 1 "VCC" H 7367 1123 50  0000 C CNN
F 2 "" H 7350 950 50  0001 C CNN
F 3 "" H 7350 950 50  0001 C CNN
	1    7350 950 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0133
U 1 1 5E3197C6
P 7350 2650
F 0 "#PWR0133" H 7350 2400 50  0001 C CNN
F 1 "GND" H 7355 2477 50  0000 C CNN
F 2 "" H 7350 2650 50  0001 C CNN
F 3 "" H 7350 2650 50  0001 C CNN
	1    7350 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7350 950  7350 1050
$Comp
L 74xx:74HCT541 U16
U 1 1 5E1D0E10
P 7600 5600
F 0 "U16" H 7400 6500 50  0000 C CNN
F 1 "74HCT541" H 7350 6400 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 7600 5600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT541" H 7600 5600 50  0001 C CNN
F 4 "Addr Tristate Buffer" H 7600 5600 50  0001 C CNN "Description"
	1    7600 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 1750 3300 1750
Wire Wire Line
	4050 1950 3300 1950
Wire Wire Line
	4050 2250 3300 2250
Wire Bus Line
	8300 700  8450 700 
Connection ~ 2750 700 
Entry Wire Line
	8300 5000 8200 5100
Entry Wire Line
	8300 5100 8200 5200
Entry Wire Line
	8300 5200 8200 5300
Entry Wire Line
	8300 5300 8200 5400
Entry Wire Line
	8300 5400 8200 5500
Entry Wire Line
	8300 5500 8200 5600
Entry Wire Line
	8300 5600 8200 5700
Entry Wire Line
	8300 5700 8200 5800
Wire Wire Line
	8100 5100 8200 5100
Wire Wire Line
	8100 5200 8200 5200
Wire Wire Line
	8100 5300 8200 5300
Wire Wire Line
	8100 5400 8200 5400
Wire Wire Line
	8100 5500 8200 5500
Wire Wire Line
	8100 5600 8200 5600
Wire Wire Line
	8100 5700 8200 5700
Wire Wire Line
	8100 5800 8200 5800
Entry Wire Line
	6500 3400 6600 3300
Entry Wire Line
	6500 3500 6600 3400
Entry Wire Line
	6500 3600 6600 3500
Entry Wire Line
	6500 3700 6600 3600
Entry Wire Line
	6500 3800 6600 3700
Entry Wire Line
	6500 3900 6600 3800
Entry Wire Line
	6500 4000 6600 3900
Entry Wire Line
	6500 4100 6600 4000
Entry Wire Line
	6500 5200 6600 5100
Entry Wire Line
	6500 5300 6600 5200
Entry Wire Line
	6500 5400 6600 5300
Entry Wire Line
	6500 5500 6600 5400
Entry Wire Line
	6500 5600 6600 5500
Entry Wire Line
	6500 5700 6600 5600
Entry Wire Line
	6500 5800 6600 5700
Entry Wire Line
	6500 5900 6600 5800
Text Label 6950 5100 0    50   ~ 0
adr0
Text Label 6950 5200 0    50   ~ 0
adr1
Text Label 6950 5300 0    50   ~ 0
adr2
Text Label 6950 5400 0    50   ~ 0
adr3
Text Label 6950 5500 0    50   ~ 0
adr4
Text Label 6950 5600 0    50   ~ 0
adr5
Text Label 6950 5700 0    50   ~ 0
adr6
Text Label 6950 5800 0    50   ~ 0
adr7
Text Label 8100 5100 0    50   ~ 0
d0
Text Label 8100 5200 0    50   ~ 0
d1
Text Label 8100 5300 0    50   ~ 0
d2
Text Label 8100 5400 0    50   ~ 0
d3
Text Label 8100 5500 0    50   ~ 0
d4
Text Label 8100 5600 0    50   ~ 0
d5
Text Label 8100 5700 0    50   ~ 0
d6
Text Label 8100 5800 0    50   ~ 0
d7
$Comp
L power:GND #PWR0134
U 1 1 5E561262
P 6950 4650
F 0 "#PWR0134" H 6950 4400 50  0001 C CNN
F 1 "GND" H 6955 4477 50  0000 C CNN
F 2 "" H 6950 4650 50  0001 C CNN
F 3 "" H 6950 4650 50  0001 C CNN
	1    6950 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0135
U 1 1 5E570BEB
P 7700 6400
F 0 "#PWR0135" H 7700 6150 50  0001 C CNN
F 1 "GND" H 7705 6227 50  0000 C CNN
F 2 "" H 7700 6400 50  0001 C CNN
F 3 "" H 7700 6400 50  0001 C CNN
	1    7700 6400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 6400 7700 6400
$Comp
L power:VCC #PWR0136
U 1 1 5E59E4FA
P 7900 4800
F 0 "#PWR0136" H 7900 4650 50  0001 C CNN
F 1 "VCC" H 7917 4973 50  0000 C CNN
F 2 "" H 7900 4800 50  0001 C CNN
F 3 "" H 7900 4800 50  0001 C CNN
	1    7900 4800
	1    0    0    -1  
$EndComp
Text GLabel 7000 6000 0    50   Input ~ 0
Lo
Text GLabel 7000 6100 0    50   Input ~ 0
~ADlowrite
Wire Wire Line
	7000 6000 7100 6000
Wire Wire Line
	7000 6100 7100 6100
Text GLabel 1050 6350 0    50   Input ~ 0
adr[0..15]
Wire Bus Line
	2750 700  3200 700 
Connection ~ 3200 700 
Wire Bus Line
	3200 700  8300 700 
Entry Wire Line
	3000 2550 3100 2450
Entry Wire Line
	3000 2650 3100 2550
Entry Wire Line
	3000 2750 3100 2650
Entry Wire Line
	3000 2850 3100 2750
Entry Wire Line
	3000 2950 3100 2850
Entry Wire Line
	3000 3050 3100 2950
Entry Wire Line
	3000 3150 3100 3050
Entry Wire Line
	3000 3250 3100 3150
Wire Wire Line
	7850 1350 8200 1350
Wire Wire Line
	7850 1450 8200 1450
Wire Wire Line
	7850 1550 8200 1550
Wire Wire Line
	7850 1650 8200 1650
Wire Wire Line
	7850 1750 8200 1750
Wire Wire Line
	7850 1850 8200 1850
Wire Wire Line
	7850 1950 8200 1950
Wire Wire Line
	7850 2050 8200 2050
Entry Wire Line
	6100 1750 6200 1650
Entry Wire Line
	6100 1850 6200 1750
Entry Wire Line
	6100 1950 6200 1850
Entry Wire Line
	6100 2050 6200 1950
Entry Wire Line
	6100 2150 6200 2050
Entry Wire Line
	6100 1650 6200 1550
Entry Wire Line
	6100 1550 6200 1450
Entry Wire Line
	6100 2450 6000 2550
Entry Wire Line
	6100 3050 6000 3150
Entry Wire Line
	6100 1450 6200 1350
Entry Wire Line
	6100 2550 6000 2650
Entry Wire Line
	6100 2650 6000 2750
Entry Wire Line
	6100 2750 6000 2850
Entry Wire Line
	6100 2850 6000 2950
Entry Wire Line
	6100 2950 6000 3050
Entry Wire Line
	6100 2350 6000 2450
Wire Wire Line
	6200 1350 6850 1350
Wire Wire Line
	6200 1450 6850 1450
Wire Wire Line
	6200 1550 6850 1550
Wire Wire Line
	6200 1650 6850 1650
Wire Wire Line
	6200 1750 6850 1750
Wire Wire Line
	6200 1850 6850 1850
Wire Wire Line
	6200 1950 6850 1950
Wire Wire Line
	6200 2050 6850 2050
Wire Wire Line
	5250 2450 6000 2450
Wire Wire Line
	5250 2550 6000 2550
Wire Wire Line
	5250 2650 6000 2650
Wire Wire Line
	5250 2750 6000 2750
Wire Wire Line
	5250 2850 6000 2850
Wire Wire Line
	5250 2950 6000 2950
Wire Wire Line
	5250 3050 6000 3050
Wire Wire Line
	5250 3150 6000 3150
Entry Wire Line
	8300 3900 8200 4000
Entry Wire Line
	8300 3800 8200 3900
Entry Wire Line
	8300 3700 8200 3800
Entry Wire Line
	8300 3600 8200 3700
Entry Wire Line
	8300 3500 8200 3600
Entry Wire Line
	8300 3400 8200 3500
Entry Wire Line
	8300 3300 8200 3400
Entry Wire Line
	8300 3200 8200 3300
Wire Wire Line
	7000 4300 7050 4300
Text GLabel 7000 4300 0    50   Input ~ 0
~ADhiwrite
Wire Wire Line
	7000 4200 7050 4200
Text GLabel 7000 4200 0    50   Input ~ 0
Lo
Wire Wire Line
	7550 3000 7700 3000
$Comp
L power:VCC #PWR0137
U 1 1 5E58FE81
P 7700 3000
F 0 "#PWR0137" H 7700 2850 50  0001 C CNN
F 1 "VCC" H 7717 3173 50  0000 C CNN
F 2 "" H 7700 3000 50  0001 C CNN
F 3 "" H 7700 3000 50  0001 C CNN
	1    7700 3000
	1    0    0    -1  
$EndComp
Text Label 6850 4000 0    50   ~ 0
adr15
Text Label 6850 3900 0    50   ~ 0
adr14
Text Label 6850 3800 0    50   ~ 0
adr13
Text Label 6850 3700 0    50   ~ 0
adr12
Text Label 6850 3600 0    50   ~ 0
adr11
Text Label 6850 3500 0    50   ~ 0
adr10
Text Label 6850 3400 0    50   ~ 0
adr9
Text Label 6850 3300 0    50   ~ 0
adr8
Text Label 8050 4000 0    50   ~ 0
d7
Text Label 8050 3900 0    50   ~ 0
d6
Text Label 8050 3800 0    50   ~ 0
d5
Text Label 8050 3700 0    50   ~ 0
d4
Text Label 8050 3600 0    50   ~ 0
d3
Text Label 8050 3500 0    50   ~ 0
d2
Text Label 8050 3400 0    50   ~ 0
d1
Text Label 8050 3300 0    50   ~ 0
d0
Wire Wire Line
	8050 4000 8200 4000
Wire Wire Line
	8050 3900 8200 3900
Wire Wire Line
	8050 3800 8200 3800
Wire Wire Line
	8050 3700 8200 3700
Wire Wire Line
	8050 3600 8200 3600
Wire Wire Line
	8050 3500 8200 3500
Wire Wire Line
	8050 3400 8200 3400
Wire Wire Line
	8050 3300 8200 3300
$Comp
L 74xx:74HCT541 U15
U 1 1 5E1D3E55
P 7550 3800
F 0 "U15" H 7300 4600 50  0000 C CNN
F 1 "74HCT541" H 7250 4500 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 7550 3800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT541" H 7550 3800 50  0001 C CNN
F 4 "Addr Tristate Buffer" H 7550 3800 50  0001 C CNN "Description"
	1    7550 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 4600 7550 4650
Wire Wire Line
	6950 4650 7550 4650
Wire Wire Line
	7600 4800 7900 4800
Wire Bus Line
	6500 6350 1050 6350
Wire Wire Line
	6600 5100 7100 5100
Wire Wire Line
	6600 5200 7100 5200
Wire Wire Line
	6600 5300 7100 5300
Wire Wire Line
	6600 5400 7100 5400
Wire Wire Line
	6600 5500 7100 5500
Wire Wire Line
	6600 5600 7100 5600
Wire Wire Line
	6600 5700 7100 5700
Wire Wire Line
	6600 5800 7100 5800
Text Label 1200 4000 0    50   ~ 0
d0
Text Label 1200 4100 0    50   ~ 0
d1
Text Label 1200 4200 0    50   ~ 0
d2
Text Label 1200 4300 0    50   ~ 0
d3
Text Label 1200 4400 0    50   ~ 0
d4
Text Label 1200 4500 0    50   ~ 0
d5
Text Label 1200 4600 0    50   ~ 0
d6
Text Label 1200 4700 0    50   ~ 0
d7
Text Notes 7450 4100 0    50   ~ 0
ADhi\nBuffer
Text Notes 7500 5900 0    50   ~ 0
ADlo\nBuffer
Wire Wire Line
	6600 3300 7050 3300
Wire Wire Line
	7050 3400 6600 3400
Wire Wire Line
	6600 3500 7050 3500
Wire Wire Line
	7050 3600 6600 3600
Wire Wire Line
	6600 3700 7050 3700
Wire Wire Line
	7050 3800 6600 3800
Wire Wire Line
	6600 3900 7050 3900
Wire Wire Line
	7050 4000 6600 4000
Text Notes 10150 650  0    50   ~ 0
Data Bus
Text Notes 1150 6300 0    50   ~ 0
Address Bus
Text Notes 7250 7000 0    50   ~ 0
The ALU reads from the data bus and the B register. The ALU's output\nis stored in the O register so it can be put back on the data bus.\nBoth the A register and the UART read/write the data bus.\nThe AD buffers allow the hi/low bytes of the address bus to be written to the data bus.
Wire Bus Line
	3200 700  3200 2250
Wire Bus Line
	2750 700  2750 2300
Wire Bus Line
	850  700  850  4600
Wire Bus Line
	3000 2550 3000 4600
Wire Bus Line
	6100 1450 6100 3050
Wire Bus Line
	6500 3400 6500 6350
Wire Bus Line
	8300 700  8300 5700
$EndSCHEMATC
