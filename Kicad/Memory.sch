EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 5
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
L 74xx:74469 U5
U 1 1 5E1AD251
P 4200 2200
F 0 "U5" H 3950 3150 50  0000 C CNN
F 1 "74LS469" H 3950 3050 50  0000 C CNN
F 2 "Package_DIP:DIP-24_W7.62mm" H 4200 2200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74469" H 4200 2200 50  0001 C CNN
F 4 "SPhi" H 4200 2200 50  0001 C CNN "Description"
	1    4200 2200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HCT574 U8
U 1 1 5E1ADA55
P 6800 2100
F 0 "U8" H 6500 2950 50  0000 C CNN
F 1 "74HCT574" H 6500 2850 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 6800 2100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT574" H 6800 2100 50  0001 C CNN
F 4 "ARhi" H 6800 2100 50  0001 C CNN "Description"
	1    6800 2100
	1    0    0    -1  
$EndComp
$Comp
L Memory_EPROM:27C64 U10
U 1 1 5E1AF91B
P 9300 2100
F 0 "U10" H 9100 3200 50  0000 C CNN
F 1 "AT28C64B" H 9050 3100 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W15.24mm" H 9300 2100 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/11107M.pdf" H 9300 2100 50  0001 C CNN
F 4 "ROM" H 9300 2100 50  0001 C CNN "Description"
	1    9300 2100
	1    0    0    -1  
$EndComp
Text Notes 9150 4600 0    50   ~ 0
RAM
Connection ~ 8250 750 
Wire Bus Line
	8250 750  10550 750 
Entry Wire Line
	8250 1200 8350 1300
Entry Wire Line
	8250 1300 8350 1400
Entry Wire Line
	8250 1400 8350 1500
Entry Wire Line
	8250 1500 8350 1600
Entry Wire Line
	8250 1600 8350 1700
Entry Wire Line
	8250 1700 8350 1800
Entry Wire Line
	8250 1800 8350 1900
Entry Wire Line
	8250 1900 8350 2000
Entry Wire Line
	8250 2000 8350 2100
Entry Wire Line
	8250 2100 8350 2200
Entry Wire Line
	8250 2200 8350 2300
Entry Wire Line
	8250 2300 8350 2400
Entry Wire Line
	8250 2400 8350 2500
Entry Wire Line
	8250 5150 8350 5250
Entry Wire Line
	8250 5050 8350 5150
Entry Wire Line
	8250 4950 8350 5050
Entry Wire Line
	8250 4850 8350 4950
Entry Wire Line
	8250 4750 8350 4850
Entry Wire Line
	8250 4650 8350 4750
Entry Wire Line
	8250 4550 8350 4650
Entry Wire Line
	8250 4450 8350 4550
Entry Wire Line
	8250 4350 8350 4450
Entry Wire Line
	8250 4250 8350 4350
Entry Wire Line
	8250 4150 8350 4250
Entry Wire Line
	8250 4050 8350 4150
Entry Wire Line
	8250 3950 8350 4050
Entry Wire Line
	8250 3850 8350 3950
Wire Wire Line
	8350 3950 8700 3950
Entry Wire Line
	8250 3750 8350 3850
Wire Wire Line
	8350 3850 8700 3850
Wire Wire Line
	8350 4050 8700 4050
Wire Wire Line
	8350 4150 8700 4150
Wire Wire Line
	8350 4250 8700 4250
Wire Wire Line
	8350 4350 8700 4350
Wire Wire Line
	8350 4450 8700 4450
Wire Wire Line
	8350 4550 8700 4550
Wire Wire Line
	8350 4650 8700 4650
Wire Wire Line
	8350 4750 8700 4750
Wire Wire Line
	8350 4850 8700 4850
Wire Wire Line
	8350 4950 8700 4950
Wire Wire Line
	8350 5050 8700 5050
Wire Wire Line
	8350 5150 8700 5150
Wire Wire Line
	8350 5250 8700 5250
Text GLabel 10550 750  2    50   Input ~ 0
adr[0..15]
Text Notes 9200 2100 0    50   ~ 0
ROM
Text GLabel 10200 6200 2    50   Input ~ 0
d[0..7]
Entry Wire Line
	10200 3950 10100 3850
Entry Wire Line
	10200 4050 10100 3950
Entry Wire Line
	10200 4150 10100 4050
Entry Wire Line
	10200 4250 10100 4150
Entry Wire Line
	10200 4350 10100 4250
Entry Wire Line
	10200 4450 10100 4350
Entry Wire Line
	10200 4550 10100 4450
Entry Wire Line
	10200 4650 10100 4550
Entry Wire Line
	10200 1400 10100 1300
Entry Wire Line
	10200 1500 10100 1400
Entry Wire Line
	10200 1600 10100 1500
Entry Wire Line
	10200 1700 10100 1600
Entry Wire Line
	10200 1800 10100 1700
Entry Wire Line
	10200 1900 10100 1800
Entry Wire Line
	10200 2000 10100 1900
Entry Wire Line
	10200 2100 10100 2000
Wire Wire Line
	9700 1300 10100 1300
Wire Wire Line
	9700 1400 10100 1400
Wire Wire Line
	9700 1500 10100 1500
Wire Wire Line
	9700 1600 10100 1600
Wire Wire Line
	9700 1700 10100 1700
Wire Wire Line
	9700 1800 10100 1800
Wire Wire Line
	9700 1900 10100 1900
Wire Wire Line
	9700 2000 10100 2000
Text Label 8450 1300 0    50   ~ 0
adr0
Text Label 8450 1400 0    50   ~ 0
adr1
Text Label 8450 1500 0    50   ~ 0
adr2
Text Label 8450 1600 0    50   ~ 0
adr3
Text Label 8450 1700 0    50   ~ 0
adr4
Text Label 8450 1800 0    50   ~ 0
adr5
Text Label 8450 1900 0    50   ~ 0
adr6
Text Label 8450 2000 0    50   ~ 0
adr7
Text Label 8450 2100 0    50   ~ 0
adr8
Text Label 8450 2200 0    50   ~ 0
adr9
Text Label 8450 2300 0    50   ~ 0
adr10
Text Label 8450 2400 0    50   ~ 0
adr11
Text Label 8450 2500 0    50   ~ 0
adr12
Text Label 8450 3850 0    50   ~ 0
adr0
Text Label 8450 3950 0    50   ~ 0
adr1
Text Label 8450 4050 0    50   ~ 0
adr2
Text Label 8450 4150 0    50   ~ 0
adr3
Text Label 8450 4250 0    50   ~ 0
adr4
Text Label 8450 4350 0    50   ~ 0
adr5
Text Label 8450 4450 0    50   ~ 0
adr6
Text Label 8450 4550 0    50   ~ 0
adr7
Text Label 8450 4650 0    50   ~ 0
adr8
Text Label 8450 4750 0    50   ~ 0
adr9
Text Label 8450 4850 0    50   ~ 0
adr10
Text Label 8450 4950 0    50   ~ 0
adr11
Text Label 8450 5050 0    50   ~ 0
adr12
Text Label 8450 5150 0    50   ~ 0
adr13
Text Label 8450 5250 0    50   ~ 0
adr14
Text Label 9800 1300 0    50   ~ 0
d0
Text Label 9800 1400 0    50   ~ 0
d1
Text Label 9800 1500 0    50   ~ 0
d2
Text Label 9800 1600 0    50   ~ 0
d3
Text Label 9800 1700 0    50   ~ 0
d4
Text Label 9800 1800 0    50   ~ 0
d5
Text Label 9800 1900 0    50   ~ 0
d6
Text Label 9800 2000 0    50   ~ 0
d7
Wire Wire Line
	9700 3850 10100 3850
Wire Wire Line
	10100 3950 9700 3950
Wire Wire Line
	9700 4050 10100 4050
Wire Wire Line
	9700 4150 10100 4150
Wire Wire Line
	9700 4250 10100 4250
Wire Wire Line
	10100 4350 9700 4350
Wire Wire Line
	9700 4450 10100 4450
Wire Wire Line
	10100 4550 9700 4550
Text Label 9800 3850 0    50   ~ 0
d0
Text Label 9800 3950 0    50   ~ 0
d1
Text Label 9800 4050 0    50   ~ 0
d2
Text Label 9800 4150 0    50   ~ 0
d3
Text Label 9800 4250 0    50   ~ 0
d4
Text Label 9800 4350 0    50   ~ 0
d5
Text Label 9800 4450 0    50   ~ 0
d6
Text Label 9800 4550 0    50   ~ 0
d7
$Comp
L 74xx:74HCT574 U7
U 1 1 5E1FD10E
P 6750 4200
F 0 "U7" H 6550 5100 50  0000 C CNN
F 1 "74HCT574" H 6500 5000 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 6750 4200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HCT574" H 6750 4200 50  0001 C CNN
F 4 "ARlo" H 6750 4200 50  0001 C CNN "Description"
	1    6750 4200
	1    0    0    -1  
$EndComp
Entry Wire Line
	7650 1500 7550 1600
Entry Wire Line
	7650 1600 7550 1700
Entry Wire Line
	7650 1700 7550 1800
Entry Wire Line
	7650 1800 7550 1900
Entry Wire Line
	7650 1900 7550 2000
Entry Wire Line
	7650 2000 7550 2100
Entry Wire Line
	7650 2100 7550 2200
Entry Wire Line
	7650 2200 7550 2300
Entry Wire Line
	7650 3600 7550 3700
Entry Wire Line
	7650 3700 7550 3800
Entry Wire Line
	7650 3800 7550 3900
Entry Wire Line
	7650 3900 7550 4000
Entry Wire Line
	7650 4000 7550 4100
Entry Wire Line
	7650 4100 7550 4200
Entry Wire Line
	7650 4200 7550 4300
Entry Wire Line
	7650 4300 7550 4400
Wire Wire Line
	7300 1600 7550 1600
Wire Wire Line
	7550 1700 7300 1700
Wire Wire Line
	7300 1800 7550 1800
Wire Wire Line
	7550 1900 7300 1900
Wire Wire Line
	7300 2000 7550 2000
Wire Wire Line
	7550 2100 7300 2100
Wire Wire Line
	7300 2200 7550 2200
Wire Wire Line
	7550 2300 7300 2300
Wire Wire Line
	7250 3700 7550 3700
Wire Wire Line
	7550 3800 7250 3800
Wire Wire Line
	7250 3900 7550 3900
Wire Wire Line
	7250 4000 7550 4000
Wire Wire Line
	7550 4100 7250 4100
Wire Wire Line
	7250 4200 7550 4200
Wire Wire Line
	7550 4300 7250 4300
Wire Wire Line
	7250 4400 7550 4400
Text Label 7300 1600 0    50   ~ 0
adr8
Text Label 7300 1700 0    50   ~ 0
adr9
Text Label 7300 1800 0    50   ~ 0
adr10
Text Label 7300 1900 0    50   ~ 0
adr11
Text Label 7300 2000 0    50   ~ 0
adr12
Text Label 7300 2100 0    50   ~ 0
adr13
Text Label 7300 2200 0    50   ~ 0
adr14
Text Label 7300 2300 0    50   ~ 0
adr15
Text Label 7300 3700 0    50   ~ 0
adr0
Text Label 7300 3800 0    50   ~ 0
adr1
Text Label 7300 3900 0    50   ~ 0
adr2
Text Label 7300 4000 0    50   ~ 0
adr3
Text Label 7300 4100 0    50   ~ 0
adr4
Text Label 7300 4200 0    50   ~ 0
adr5
Text Label 7300 4300 0    50   ~ 0
adr6
Text Label 7300 4400 0    50   ~ 0
adr7
Text Notes 6750 2100 0    50   ~ 0
ADhi
Text Notes 6700 4200 0    50   ~ 0
ADlo
Connection ~ 5700 6200
Wire Bus Line
	5850 6200 5700 6200
Entry Wire Line
	5700 1700 5800 1600
Entry Wire Line
	5700 1800 5800 1700
Entry Wire Line
	5700 1900 5800 1800
Entry Wire Line
	5700 2000 5800 1900
Entry Wire Line
	5700 2100 5800 2000
Entry Wire Line
	5700 2200 5800 2100
Entry Wire Line
	5700 2300 5800 2200
Entry Wire Line
	5700 2400 5800 2300
Entry Wire Line
	5700 3800 5800 3700
Entry Wire Line
	5700 3900 5800 3800
Entry Wire Line
	5700 4000 5800 3900
Entry Wire Line
	5700 4100 5800 4000
Entry Wire Line
	5700 4200 5800 4100
Entry Wire Line
	5700 4300 5800 4200
Entry Wire Line
	5700 4400 5800 4300
Entry Wire Line
	5700 4500 5800 4400
Wire Wire Line
	5800 1600 6300 1600
Wire Wire Line
	6300 1700 5800 1700
Wire Wire Line
	5800 1800 6300 1800
Wire Wire Line
	6300 1900 5800 1900
Wire Wire Line
	5800 2000 6300 2000
Wire Wire Line
	6300 2100 5800 2100
Wire Wire Line
	5800 2200 6300 2200
Wire Wire Line
	6300 2300 5800 2300
Wire Wire Line
	5800 3700 6250 3700
Wire Wire Line
	6250 3800 5800 3800
Wire Wire Line
	5800 3900 6250 3900
Wire Wire Line
	6250 4000 5800 4000
Wire Wire Line
	5800 4100 6250 4100
Wire Wire Line
	6250 4200 5800 4200
Wire Wire Line
	5800 4300 6250 4300
Wire Wire Line
	6250 4400 5800 4400
Text Label 5900 1600 0    50   ~ 0
d0
Text Label 5900 1700 0    50   ~ 0
d1
Text Label 5900 1800 0    50   ~ 0
d2
Text Label 5900 1900 0    50   ~ 0
d3
Text Label 5900 2000 0    50   ~ 0
d4
Text Label 5900 2100 0    50   ~ 0
d5
Text Label 5900 2200 0    50   ~ 0
d6
Text Label 5900 2300 0    50   ~ 0
d7
Text Label 5900 3700 0    50   ~ 0
d0
Text Label 5900 3800 0    50   ~ 0
d1
Text Label 5900 3900 0    50   ~ 0
d2
Text Label 5900 4000 0    50   ~ 0
d3
Text Label 5900 4100 0    50   ~ 0
d4
Text Label 5900 4200 0    50   ~ 0
d5
Text Label 5900 4300 0    50   ~ 0
d6
Text Label 5900 4400 0    50   ~ 0
d7
$Comp
L 74xx:74469 U6
U 1 1 5E26C0BE
P 4200 4300
F 0 "U6" H 3950 5250 50  0000 C CNN
F 1 "74LS469" H 3950 5150 50  0000 C CNN
F 2 "Package_DIP:DIP-24_W7.62mm" H 4200 4300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74469" H 4200 4300 50  0001 C CNN
F 4 "SPlo" H 4200 4300 50  0001 C CNN "Description"
	1    4200 4300
	1    0    0    -1  
$EndComp
Entry Wire Line
	5100 1500 5000 1600
Entry Wire Line
	5100 1600 5000 1700
Entry Wire Line
	5100 1700 5000 1800
Entry Wire Line
	5100 1800 5000 1900
Entry Wire Line
	5100 1900 5000 2000
Entry Wire Line
	5100 2000 5000 2100
Entry Wire Line
	5100 2100 5000 2200
Entry Wire Line
	5100 2200 5000 2300
Entry Wire Line
	5100 3600 5000 3700
Entry Wire Line
	5100 3700 5000 3800
Entry Wire Line
	5100 3800 5000 3900
Entry Wire Line
	5100 3900 5000 4000
Entry Wire Line
	5100 4000 5000 4100
Entry Wire Line
	5100 4100 5000 4200
Entry Wire Line
	5100 4200 5000 4300
Entry Wire Line
	5100 4300 5000 4400
Wire Wire Line
	4700 3700 5000 3700
Wire Wire Line
	5000 3800 4700 3800
Wire Wire Line
	4700 3900 5000 3900
Wire Wire Line
	4700 4000 5000 4000
Wire Wire Line
	5000 4100 4700 4100
Wire Wire Line
	4700 4200 5000 4200
Wire Wire Line
	5000 4300 4700 4300
Wire Wire Line
	4700 4400 5000 4400
Text Label 4750 1600 0    50   ~ 0
adr8
Text Label 4750 1700 0    50   ~ 0
adr9
Text Label 4750 1800 0    50   ~ 0
adr10
Text Label 4750 1900 0    50   ~ 0
adr11
Text Label 4750 2000 0    50   ~ 0
adr12
Text Label 4750 2100 0    50   ~ 0
adr13
Text Label 4750 2200 0    50   ~ 0
adr14
Text Label 4750 2300 0    50   ~ 0
adr15
Text Label 4750 3700 0    50   ~ 0
adr0
Text Label 4750 3800 0    50   ~ 0
adr1
Text Label 4750 3900 0    50   ~ 0
adr2
Text Label 4750 4000 0    50   ~ 0
adr3
Text Label 4750 4100 0    50   ~ 0
adr4
Text Label 4750 4200 0    50   ~ 0
adr5
Text Label 4750 4300 0    50   ~ 0
adr6
Text Label 4750 4400 0    50   ~ 0
adr7
Wire Wire Line
	4700 1600 5000 1600
Wire Wire Line
	4700 1700 5000 1700
Wire Wire Line
	4700 1800 5000 1800
Wire Wire Line
	4700 1900 5000 1900
Wire Wire Line
	4700 2000 5000 2000
Wire Wire Line
	4700 2100 5000 2100
Wire Wire Line
	4700 2200 5000 2200
Wire Wire Line
	4700 2300 5000 2300
Text Notes 4150 2100 0    50   ~ 0
SPhi
Text Notes 4150 4150 0    50   ~ 0
SPlo
Text Notes 1750 1950 0    50   ~ 0
PChi
Text Notes 1750 4050 0    50   ~ 0
PClo
Entry Wire Line
	3200 1700 3300 1600
Entry Wire Line
	3200 1800 3300 1700
Entry Wire Line
	3200 1900 3300 1800
Entry Wire Line
	3200 2000 3300 1900
Entry Wire Line
	3200 2100 3300 2000
Entry Wire Line
	3200 2200 3300 2100
Entry Wire Line
	3200 2300 3300 2200
Entry Wire Line
	3200 2400 3300 2300
Entry Wire Line
	3200 3800 3300 3700
Entry Wire Line
	3200 3900 3300 3800
Entry Wire Line
	3200 4000 3300 3900
Entry Wire Line
	3200 4100 3300 4000
Entry Wire Line
	3200 4200 3300 4100
Entry Wire Line
	3200 4300 3300 4200
Entry Wire Line
	3200 4400 3300 4300
Entry Wire Line
	3200 4500 3300 4400
Wire Wire Line
	3300 1600 3700 1600
Wire Wire Line
	3300 1800 3700 1800
Wire Wire Line
	3300 2000 3700 2000
Wire Wire Line
	3300 2200 3700 2200
Text Label 3600 1600 0    50   ~ 0
d0
Text Label 3600 1700 0    50   ~ 0
d1
Text Label 3600 1800 0    50   ~ 0
d2
Text Label 3600 1900 0    50   ~ 0
d3
Text Label 3600 2000 0    50   ~ 0
d4
Text Label 3600 2100 0    50   ~ 0
d5
Text Label 3600 2200 0    50   ~ 0
d6
Text Label 3600 2300 0    50   ~ 0
d7
Text Label 3600 3700 0    50   ~ 0
d0
Text Label 3600 3800 0    50   ~ 0
d1
Text Label 3600 3900 0    50   ~ 0
d2
Text Label 3600 4000 0    50   ~ 0
d3
Text Label 3600 4100 0    50   ~ 0
d4
Text Label 3600 4200 0    50   ~ 0
d5
Text Label 3600 4300 0    50   ~ 0
d6
Text Label 3600 4400 0    50   ~ 0
d7
Wire Wire Line
	3300 3700 3700 3700
Wire Wire Line
	3300 4400 3700 4400
Wire Wire Line
	3300 4300 3700 4300
Wire Wire Line
	3300 4200 3700 4200
Wire Wire Line
	3300 4100 3700 4100
Wire Wire Line
	3300 4000 3700 4000
Wire Wire Line
	3300 3900 3700 3900
Wire Wire Line
	3300 3800 3700 3800
Wire Wire Line
	3700 1700 3300 1700
Wire Wire Line
	3700 1900 3300 1900
Wire Wire Line
	3700 2100 3300 2100
Wire Wire Line
	3700 2300 3300 2300
Wire Bus Line
	6200 6200 5700 6200
Entry Wire Line
	850  4300 950  4400
Entry Wire Line
	850  4200 950  4300
Entry Wire Line
	850  4100 950  4200
Entry Wire Line
	850  4000 950  4100
Entry Wire Line
	850  3900 950  4000
Entry Wire Line
	850  3800 950  3900
Entry Wire Line
	850  3700 950  3800
Entry Wire Line
	850  3600 950  3700
Entry Wire Line
	850  2200 950  2300
Entry Wire Line
	850  2100 950  2200
Entry Wire Line
	850  2000 950  2100
Entry Wire Line
	850  1900 950  2000
Entry Wire Line
	850  1800 950  1900
Entry Wire Line
	850  1700 950  1800
Entry Wire Line
	850  1600 950  1700
Entry Wire Line
	850  1500 950  1600
Text Label 1050 2200 0    50   ~ 0
adr9
Text Label 1000 2100 0    50   ~ 0
adr10
Text Label 1000 2000 0    50   ~ 0
adr11
Text Label 1000 1900 0    50   ~ 0
adr12
Text Label 1000 1800 0    50   ~ 0
adr13
Text Label 1000 1700 0    50   ~ 0
adr14
Text Label 1000 1600 0    50   ~ 0
adr15
Wire Wire Line
	950  3700 1300 3700
Wire Wire Line
	950  3800 1300 3800
Wire Wire Line
	950  3900 1300 3900
Wire Wire Line
	950  4000 1300 4000
Wire Wire Line
	950  4100 1300 4100
Wire Wire Line
	950  4200 1300 4200
Wire Wire Line
	950  4300 1300 4300
Wire Wire Line
	950  4400 1300 4400
Text Label 1000 4400 0    50   ~ 0
adr0
Text Label 1000 4300 0    50   ~ 0
adr1
Text Label 1000 4200 0    50   ~ 0
adr2
Text Label 1000 4100 0    50   ~ 0
adr3
Text Label 1000 4000 0    50   ~ 0
adr4
Text Label 1000 3900 0    50   ~ 0
adr5
Text Label 1000 3800 0    50   ~ 0
adr6
Text Label 1000 3700 0    50   ~ 0
adr7
Wire Bus Line
	8250 750  8950 750 
Connection ~ 5100 750 
Wire Bus Line
	5100 750  7650 750 
Wire Bus Line
	7650 750  8250 750 
Connection ~ 7650 750 
Wire Wire Line
	8350 1300 8900 1300
Wire Wire Line
	8350 1400 8900 1400
Wire Wire Line
	8350 1500 8900 1500
Wire Wire Line
	8350 1600 8900 1600
Wire Wire Line
	8350 1700 8900 1700
Wire Wire Line
	8350 1800 8900 1800
Wire Wire Line
	8350 1900 8900 1900
Wire Wire Line
	8350 2000 8900 2000
Wire Wire Line
	8350 2100 8900 2100
Wire Wire Line
	8350 2200 8900 2200
Wire Wire Line
	8350 2300 8900 2300
Wire Wire Line
	8350 2400 8900 2400
Wire Wire Line
	8350 2500 8900 2500
$Comp
L 74xx:74LS138 U3
U 1 1 5E1CA453
P 1800 6800
F 0 "U3" H 1550 7550 50  0000 C CNN
F 1 "74HCT138" H 1550 7450 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 1800 6800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS138" H 1800 6800 50  0001 C CNN
F 4 "Address Decode" H 1800 6800 50  0001 C CNN "Description"
	1    1800 6800
	1    0    0    -1  
$EndComp
Entry Wire Line
	850  6600 950  6700
Entry Wire Line
	850  6500 950  6600
Entry Wire Line
	850  6400 950  6500
Wire Wire Line
	950  6500 1300 6500
Wire Wire Line
	950  6600 1300 6600
Wire Wire Line
	950  6700 1300 6700
NoConn ~ 2300 6600
NoConn ~ 2300 6700
NoConn ~ 2300 6800
NoConn ~ 2300 6900
NoConn ~ 2300 7000
NoConn ~ 2300 7100
NoConn ~ 2300 7200
Text Label 1000 6500 0    50   ~ 0
adr13
Text Label 1000 6600 0    50   ~ 0
adr14
Text Label 1000 6700 0    50   ~ 0
adr15
Text GLabel 3200 6500 2    50   Input ~ 0
~ROMena
Wire Wire Line
	2300 6500 2450 6500
Wire Wire Line
	2450 7100 2450 6500
Text GLabel 2600 7100 2    50   Input ~ 0
RAMena
Text GLabel 8700 2900 0    50   Input ~ 0
~ROMena
Text GLabel 9750 4750 2    50   Input ~ 0
~RAMena
Text Notes 1600 6900 0    50   ~ 0
Address\nDecode
$Comp
L power:VCC #PWR0101
U 1 1 5E33F3A7
P 1800 6100
F 0 "#PWR0101" H 1800 5950 50  0001 C CNN
F 1 "VCC" H 1817 6273 50  0000 C CNN
F 2 "" H 1800 6100 50  0001 C CNN
F 3 "" H 1800 6100 50  0001 C CNN
	1    1800 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 6100 1800 6200
$Comp
L power:GND #PWR0102
U 1 1 5E34EFF5
P 1800 7550
F 0 "#PWR0102" H 1800 7300 50  0001 C CNN
F 1 "GND" H 1805 7377 50  0000 C CNN
F 2 "" H 1800 7550 50  0001 C CNN
F 3 "" H 1800 7550 50  0001 C CNN
	1    1800 7550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 7550 1800 7500
Wire Wire Line
	2450 6500 3200 6500
Connection ~ 2450 6500
Wire Wire Line
	1300 7000 1050 7000
Wire Wire Line
	1300 7200 1050 7200
Wire Wire Line
	1300 7100 1300 7200
Connection ~ 1300 7200
$Comp
L power:GND #PWR0103
U 1 1 5E3E830A
P 2550 4700
F 0 "#PWR0103" H 2550 4450 50  0001 C CNN
F 1 "GND" H 2555 4527 50  0000 C CNN
F 2 "" H 2550 4700 50  0001 C CNN
F 3 "" H 2550 4700 50  0001 C CNN
	1    2550 4700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 5E3EB117
P 4200 5300
F 0 "#PWR0104" H 4200 5050 50  0001 C CNN
F 1 "GND" H 4205 5127 50  0000 C CNN
F 2 "" H 4200 5300 50  0001 C CNN
F 3 "" H 4200 5300 50  0001 C CNN
	1    4200 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 5200 4200 5300
$Comp
L power:GND #PWR0105
U 1 1 5E40EE34
P 2600 2600
F 0 "#PWR0105" H 2600 2350 50  0001 C CNN
F 1 "GND" H 2605 2427 50  0000 C CNN
F 2 "" H 2600 2600 50  0001 C CNN
F 3 "" H 2600 2600 50  0001 C CNN
	1    2600 2600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0106
U 1 1 5E41016E
P 2550 3650
F 0 "#PWR0106" H 2550 3500 50  0001 C CNN
F 1 "VCC" H 2567 3823 50  0000 C CNN
F 2 "" H 2550 3650 50  0001 C CNN
F 3 "" H 2550 3650 50  0001 C CNN
	1    2550 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 5E430F6E
P 4100 3100
F 0 "#PWR0107" H 4100 2850 50  0001 C CNN
F 1 "GND" H 4105 2927 50  0000 C CNN
F 2 "" H 4100 3100 50  0001 C CNN
F 3 "" H 4100 3100 50  0001 C CNN
	1    4100 3100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0108
U 1 1 5E4316DE
P 4300 3400
F 0 "#PWR0108" H 4300 3250 50  0001 C CNN
F 1 "VCC" H 4317 3573 50  0000 C CNN
F 2 "" H 4300 3400 50  0001 C CNN
F 3 "" H 4300 3400 50  0001 C CNN
	1    4300 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 3100 4200 3100
Wire Wire Line
	4200 3400 4300 3400
$Comp
L power:VCC #PWR0109
U 1 1 5E454373
P 2600 1450
F 0 "#PWR0109" H 2600 1300 50  0001 C CNN
F 1 "VCC" H 2617 1623 50  0000 C CNN
F 2 "" H 2600 1450 50  0001 C CNN
F 3 "" H 2600 1450 50  0001 C CNN
	1    2600 1450
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0110
U 1 1 5E478827
P 4200 1250
F 0 "#PWR0110" H 4200 1100 50  0001 C CNN
F 1 "VCC" H 4217 1423 50  0000 C CNN
F 2 "" H 4200 1250 50  0001 C CNN
F 3 "" H 4200 1250 50  0001 C CNN
	1    4200 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 1250 4200 1300
$Comp
L power:VCC #PWR0111
U 1 1 5E48C56F
P 6800 1250
F 0 "#PWR0111" H 6800 1100 50  0001 C CNN
F 1 "VCC" H 6817 1423 50  0000 C CNN
F 2 "" H 6800 1250 50  0001 C CNN
F 3 "" H 6800 1250 50  0001 C CNN
	1    6800 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 1250 6800 1300
$Comp
L power:VCC #PWR0112
U 1 1 5E49F9B5
P 6750 3350
F 0 "#PWR0112" H 6750 3200 50  0001 C CNN
F 1 "VCC" H 6767 3523 50  0000 C CNN
F 2 "" H 6750 3350 50  0001 C CNN
F 3 "" H 6750 3350 50  0001 C CNN
	1    6750 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 3350 6750 3400
$Comp
L power:GND #PWR0113
U 1 1 5E4B2FC8
P 6900 2900
F 0 "#PWR0113" H 6900 2650 50  0001 C CNN
F 1 "GND" H 6905 2727 50  0000 C CNN
F 2 "" H 6900 2900 50  0001 C CNN
F 3 "" H 6900 2900 50  0001 C CNN
	1    6900 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 2900 6900 2900
$Comp
L power:GND #PWR0114
U 1 1 5E4C483C
P 6750 5050
F 0 "#PWR0114" H 6750 4800 50  0001 C CNN
F 1 "GND" H 6755 4877 50  0000 C CNN
F 2 "" H 6750 5050 50  0001 C CNN
F 3 "" H 6750 5050 50  0001 C CNN
	1    6750 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 5000 6750 5050
$Comp
L power:GND #PWR0115
U 1 1 5E4D8C0F
P 9200 5700
F 0 "#PWR0115" H 9200 5450 50  0001 C CNN
F 1 "GND" H 9205 5527 50  0000 C CNN
F 2 "" H 9200 5700 50  0001 C CNN
F 3 "" H 9200 5700 50  0001 C CNN
	1    9200 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 5650 9200 5700
$Comp
L power:GND #PWR0116
U 1 1 5E4EC9B3
P 9400 3200
F 0 "#PWR0116" H 9400 2950 50  0001 C CNN
F 1 "GND" H 9405 3027 50  0000 C CNN
F 2 "" H 9400 3200 50  0001 C CNN
F 3 "" H 9400 3200 50  0001 C CNN
	1    9400 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 3200 9400 3200
$Comp
L power:VCC #PWR0117
U 1 1 5E50F5B1
P 9200 3600
F 0 "#PWR0117" H 9200 3450 50  0001 C CNN
F 1 "VCC" H 9217 3773 50  0000 C CNN
F 2 "" H 9200 3600 50  0001 C CNN
F 3 "" H 9200 3600 50  0001 C CNN
	1    9200 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 3650 9200 3600
$Comp
L power:VCC #PWR0118
U 1 1 5E52260C
P 9300 1050
F 0 "#PWR0118" H 9300 900 50  0001 C CNN
F 1 "VCC" H 9317 1223 50  0000 C CNN
F 2 "" H 9300 1050 50  0001 C CNN
F 3 "" H 9300 1050 50  0001 C CNN
	1    9300 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 1100 9300 1050
Text GLabel 1050 7000 0    50   Input ~ 0
Hi
Text GLabel 1050 7200 0    50   Input ~ 0
Lo
Text GLabel 8550 5450 0    50   Input ~ 0
Lo
Wire Wire Line
	8550 5450 8700 5450
Wire Wire Line
	9700 5050 9750 5050
Text GLabel 8700 2700 0    50   Input ~ 0
Hi
Wire Wire Line
	8700 2700 8900 2700
Text GLabel 9750 4850 2    50   Input ~ 0
Hi
Wire Wire Line
	9700 4750 9750 4750
Wire Wire Line
	9700 4850 9750 4850
Wire Wire Line
	8900 2900 8700 2900
Text GLabel 8700 3000 0    50   Input ~ 0
~MEMwrite
Text GLabel 9750 4950 2    50   Input ~ 0
~MEMwrite
Wire Wire Line
	8700 3000 8900 3000
Text GLabel 6100 4600 0    50   Input ~ 0
ARloread
Wire Wire Line
	6100 4600 6250 4600
Text GLabel 6100 2500 0    50   Input ~ 0
ARhiread
Wire Wire Line
	6100 2500 6300 2500
Text GLabel 6050 2600 0    50   Input ~ 0
~ARwrite
Text GLabel 6050 4700 0    50   Input ~ 0
~ARwrite
Wire Wire Line
	6050 4700 6250 4700
Wire Wire Line
	6050 2600 6300 2600
NoConn ~ 8900 2800
Text GLabel 2650 1800 2    50   Input ~ 0
~PCwrite
Text GLabel 2600 3900 2    50   Input ~ 0
~PCwrite
Text GLabel 2600 4500 2    50   Input ~ 0
~PCread
Text GLabel 2650 2400 2    50   Input ~ 0
~PCread
Text GLabel 1200 2400 0    50   Input ~ 0
~Clkbar
Text GLabel 1200 4500 0    50   Input ~ 0
~Clkbar
Text GLabel 2850 2500 2    50   Input ~ 0
Lo
Text GLabel 2850 2300 2    50   Input ~ 0
Hi
NoConn ~ 4700 2600
Text GLabel 3650 2500 0    50   Input ~ 0
~Clkbar
Wire Wire Line
	3650 2500 3700 2500
Text GLabel 4750 2500 2    50   Input ~ 0
~SPwrite
Text GLabel 4750 4600 2    50   Input ~ 0
~SPwrite
Wire Wire Line
	4700 2500 4750 2500
Wire Wire Line
	4700 4600 4750 4600
Text GLabel 4750 4700 2    50   Output ~ 0
~SPcarry
Wire Wire Line
	4700 4700 4750 4700
Text GLabel 3650 2800 0    50   Input ~ 0
~SPcarry
Wire Wire Line
	3650 2800 3700 2800
Text GLabel 3650 4600 0    50   Input ~ 0
~Clkbar
Wire Wire Line
	3650 4600 3700 4600
Text GLabel 3650 4900 0    50   Input ~ 0
StkOp1
Text GLabel 3650 2700 0    50   Input ~ 0
StkOp0
Text GLabel 3650 4800 0    50   Input ~ 0
StkOp0
Text GLabel 3650 2600 0    50   Input ~ 0
~SPhiread
Wire Wire Line
	3650 2600 3700 2600
Wire Wire Line
	3650 2700 3700 2700
Text GLabel 3650 4700 0    50   Input ~ 0
~SPloread
Wire Wire Line
	3650 4700 3700 4700
Wire Bus Line
	3200 6200 5700 6200
Wire Wire Line
	3650 4800 3700 4800
Wire Wire Line
	3650 4900 3700 4900
Wire Bus Line
	5700 6200 10200 6200
Text GLabel 2650 4600 2    50   Input ~ 0
~PCincr
Wire Wire Line
	9700 4950 9750 4950
Entry Wire Line
	8250 5250 8350 5350
Wire Wire Line
	8350 5350 8700 5350
Text Label 8450 5350 0    50   ~ 0
adr15
Text GLabel 9750 5050 2    50   Input ~ 0
~MEMread
Text Notes 10000 700  0    50   ~ 0
Address Bus
Text Notes 9800 6150 0    50   ~ 0
Data Bus
Wire Wire Line
	2450 7100 2600 7100
Wire Bus Line
	850  750  5100 750 
$Comp
L 74LS593:74LS593 U1
U 1 1 5EBC9699
P 1750 2050
F 0 "U1" H 1850 2750 50  0000 C CNN
F 1 "74LS593" H 1850 2650 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm_Socket" H 1750 2050 50  0001 C CNN
F 3 "" H 1750 2050 50  0001 C CNN
F 4 "PChi" H 1750 2050 50  0001 C CNN "Description"
	1    1750 2050
	1    0    0    -1  
$EndComp
Text Label 1050 2300 0    50   ~ 0
adr8
Wire Wire Line
	950  1600 1300 1600
Wire Wire Line
	950  1700 1300 1700
Wire Wire Line
	950  1800 1300 1800
Wire Wire Line
	950  1900 1300 1900
Wire Wire Line
	950  2000 1300 2000
Wire Wire Line
	950  2100 1300 2100
Wire Wire Line
	950  2200 1300 2200
Wire Wire Line
	950  2300 1300 2300
$Comp
L 74LS593:74LS593 U2
U 1 1 5ECC48CE
P 1750 4150
F 0 "U2" H 1850 4850 50  0000 C CNN
F 1 "74LS593" H 1850 4750 50  0000 C CNN
F 2 "Package_DIP:DIP-20_W7.62mm_Socket" H 1750 4150 50  0001 C CNN
F 3 "" H 1750 4150 50  0001 C CNN
F 4 "PClo" H 1750 4150 50  0001 C CNN "Description"
	1    1750 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 2400 1300 2400
Wire Wire Line
	1200 4500 1300 4500
Wire Wire Line
	2350 3700 2450 3700
Wire Wire Line
	2450 3700 2450 3050
Wire Wire Line
	2450 3050 1250 3050
Wire Wire Line
	1250 3050 1250 2500
Wire Wire Line
	1250 2500 1300 2500
Text GLabel 2700 1700 2    50   Input ~ 0
~Reset
Text GLabel 2650 3800 2    50   Input ~ 0
~Reset
Wire Wire Line
	2350 1700 2700 1700
Wire Wire Line
	2350 3800 2650 3800
NoConn ~ 2350 1600
Wire Wire Line
	2350 1800 2650 1800
Wire Wire Line
	2350 3900 2600 3900
Wire Wire Line
	2350 2300 2850 2300
Text GLabel 2800 4400 2    50   Input ~ 0
Hi
Wire Wire Line
	2350 4400 2800 4400
Wire Wire Line
	2350 2400 2650 2400
Wire Wire Line
	2350 4500 2600 4500
Wire Wire Line
	2350 4600 2650 4600
Wire Wire Line
	2350 2500 2500 2500
Wire Wire Line
	2350 2200 2500 2200
Wire Wire Line
	2500 2200 2500 2500
Connection ~ 2500 2500
Wire Wire Line
	2500 2500 2850 2500
Text GLabel 2800 4200 2    50   Input ~ 0
Lo
Wire Wire Line
	2350 4200 2400 4200
Wire Wire Line
	2400 4200 2400 4300
Wire Wire Line
	2400 4300 2350 4300
Connection ~ 2400 4200
Wire Wire Line
	2400 4200 2800 4200
Wire Wire Line
	1300 4600 1300 4500
Connection ~ 1300 4500
Wire Wire Line
	2600 1450 2600 1900
Wire Wire Line
	2600 1900 2350 1900
Wire Wire Line
	2350 2000 2600 2000
Wire Wire Line
	2600 2000 2600 2600
Wire Wire Line
	2350 4100 2550 4100
Wire Wire Line
	2550 4100 2550 4700
Wire Wire Line
	2350 4000 2550 4000
Wire Wire Line
	2550 3650 2550 4000
Wire Wire Line
	2500 2200 2500 2100
Wire Wire Line
	2500 2100 2350 2100
Connection ~ 2500 2200
Text Notes 2600 6850 0    50   ~ 0
Low 8K is ROM,\nremainder is RAM
Text Notes 7050 6950 0    50   ~ 0
PC, SP and AR can write to the address bus which RAM and ROM reads.\nPC can only read from the address bus.\nSP and AR only read from the data bus.\nROM and RAM write to the data bus. RAM reads also!
$Comp
L Memory_RAM:AS6C1008 U9
U 1 1 5EC8B164
P 9200 3600
F 0 "U9" H 9000 3750 50  0000 C CNN
F 1 "AS6C1008" H 8950 3650 50  0000 C CNN
F 2 "Package_DIP:DIP-32_W15.24mm" H 9200 3600 50  0001 C CNN
F 3 "" H 9200 3600 50  0001 C CNN
	1    9200 3600
	1    0    0    -1  
$EndComp
Wire Bus Line
	850  750  850  6600
Wire Bus Line
	3200 1700 3200 6200
Wire Bus Line
	5100 750  5100 4300
Wire Bus Line
	5700 1700 5700 6200
Wire Bus Line
	7650 750  7650 4300
Wire Bus Line
	10200 1400 10200 6200
Wire Bus Line
	8250 750  8250 5250
$EndSCHEMATC
