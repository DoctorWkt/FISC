EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 5
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
L power:VCC #PWR0119
U 1 1 5E33D733
P 9300 900
F 0 "#PWR0119" H 9300 750 50  0001 C CNN
F 1 "VCC" H 9317 1073 50  0000 C CNN
F 2 "" H 9300 900 50  0001 C CNN
F 3 "" H 9300 900 50  0001 C CNN
	1    9300 900 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0120
U 1 1 5E33DAE2
P 9300 1450
F 0 "#PWR0120" H 9300 1200 50  0001 C CNN
F 1 "GND" H 9305 1277 50  0000 C CNN
F 2 "" H 9300 1450 50  0001 C CNN
F 3 "" H 9300 1450 50  0001 C CNN
	1    9300 1450
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5E33DE26
P 9100 1050
F 0 "#FLG0101" H 9100 1125 50  0001 C CNN
F 1 "PWR_FLAG" V 9100 1177 50  0000 L CNN
F 2 "" H 9100 1050 50  0001 C CNN
F 3 "~" H 9100 1050 50  0001 C CNN
	1    9100 1050
	0    -1   -1   0   
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5E33E3A8
P 9100 1250
F 0 "#FLG0102" H 9100 1325 50  0001 C CNN
F 1 "PWR_FLAG" V 9100 1377 50  0000 L CNN
F 2 "" H 9100 1250 50  0001 C CNN
F 3 "~" H 9100 1250 50  0001 C CNN
	1    9100 1250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9100 1050 9300 1050
Wire Wire Line
	9300 1050 9300 900 
Wire Wire Line
	9100 1250 9300 1250
Wire Wire Line
	9300 1250 9300 1450
Text GLabel 9450 1050 2    50   Output ~ 0
Hi
Text GLabel 9450 1250 2    50   Output ~ 0
Lo
Wire Wire Line
	9450 1050 9300 1050
Connection ~ 9300 1050
Wire Wire Line
	9450 1250 9300 1250
Connection ~ 9300 1250
Text GLabel 10250 2250 2    50   Output ~ 0
Clk
Text GLabel 10200 3500 2    50   Output ~ 0
~Reset
$Comp
L Device:C_Small C1
U 1 1 5EBCB38E
P 900 1150
F 0 "C1" H 850 1350 50  0000 L CNN
F 1 "0.1uF" H 850 950 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 900 1150 50  0001 C CNN
F 3 "~" H 900 1150 50  0001 C CNN
F 4 "Bypass caps" H 900 1150 50  0001 C CNN "Description"
	1    900  1150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 5EBD984B
P 1150 1150
F 0 "C4" H 1100 1350 50  0000 L CNN
F 1 "0.1uF" H 1100 950 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1150 1150 50  0001 C CNN
F 3 "~" H 1150 1150 50  0001 C CNN
F 4 "Bypass caps" H 1150 1150 50  0001 C CNN "Description"
	1    1150 1150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C7
U 1 1 5EBD9B1D
P 1400 1150
F 0 "C7" H 1350 1350 50  0000 L CNN
F 1 "0.1uF" H 1350 950 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1400 1150 50  0001 C CNN
F 3 "~" H 1400 1150 50  0001 C CNN
F 4 "Bypass caps" H 1400 1150 50  0001 C CNN "Description"
	1    1400 1150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C10
U 1 1 5EBD9EC7
P 1650 1150
F 0 "C10" H 1600 1350 50  0000 L CNN
F 1 "0.1uF" H 1600 950 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1650 1150 50  0001 C CNN
F 3 "~" H 1650 1150 50  0001 C CNN
F 4 "Bypass caps" H 1650 1150 50  0001 C CNN "Description"
	1    1650 1150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C13
U 1 1 5EBDFE8F
P 1900 1150
F 0 "C13" H 1850 1350 50  0000 L CNN
F 1 "0.1uF" H 1850 950 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1900 1150 50  0001 C CNN
F 3 "~" H 1900 1150 50  0001 C CNN
F 4 "Bypass caps" H 1900 1150 50  0001 C CNN "Description"
	1    1900 1150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C16
U 1 1 5EBE0132
P 2150 1150
F 0 "C16" H 2100 1350 50  0000 L CNN
F 1 "0.1uF" H 2100 950 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2150 1150 50  0001 C CNN
F 3 "~" H 2150 1150 50  0001 C CNN
F 4 "Bypass caps" H 2150 1150 50  0001 C CNN "Description"
	1    2150 1150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C19
U 1 1 5EBE045B
P 2400 1150
F 0 "C19" H 2350 1350 50  0000 L CNN
F 1 "0.1uF" H 2350 950 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2400 1150 50  0001 C CNN
F 3 "~" H 2400 1150 50  0001 C CNN
F 4 "Bypass caps" H 2400 1150 50  0001 C CNN "Description"
	1    2400 1150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C22
U 1 1 5EBE0703
P 2650 1150
F 0 "C22" H 2600 1350 50  0000 L CNN
F 1 "0.1uF" H 2600 950 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2650 1150 50  0001 C CNN
F 3 "~" H 2650 1150 50  0001 C CNN
F 4 "Bypass caps" H 2650 1150 50  0001 C CNN "Description"
	1    2650 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	900  1050 1150 1050
Wire Wire Line
	1150 1050 1400 1050
Connection ~ 1150 1050
Wire Wire Line
	1400 1050 1650 1050
Connection ~ 1400 1050
Wire Wire Line
	1650 1050 1900 1050
Connection ~ 1650 1050
Wire Wire Line
	1900 1050 2150 1050
Connection ~ 1900 1050
Wire Wire Line
	2150 1050 2400 1050
Connection ~ 2150 1050
Wire Wire Line
	2400 1050 2650 1050
Connection ~ 2400 1050
Wire Wire Line
	900  1250 1150 1250
Wire Wire Line
	1150 1250 1400 1250
Connection ~ 1150 1250
Wire Wire Line
	1400 1250 1650 1250
Connection ~ 1400 1250
Wire Wire Line
	1650 1250 1900 1250
Connection ~ 1650 1250
Wire Wire Line
	2150 1250 1900 1250
Connection ~ 1900 1250
Wire Wire Line
	2150 1250 2400 1250
Connection ~ 2150 1250
Wire Wire Line
	2400 1250 2650 1250
Connection ~ 2400 1250
$Comp
L power:VCC #PWR03
U 1 1 5EBFA0B1
P 2950 950
F 0 "#PWR03" H 2950 800 50  0001 C CNN
F 1 "VCC" H 2967 1123 50  0000 C CNN
F 2 "" H 2950 950 50  0001 C CNN
F 3 "" H 2950 950 50  0001 C CNN
	1    2950 950 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5EBFAACE
P 2950 1350
F 0 "#PWR04" H 2950 1100 50  0001 C CNN
F 1 "GND" H 2955 1177 50  0000 C CNN
F 2 "" H 2950 1350 50  0001 C CNN
F 3 "" H 2950 1350 50  0001 C CNN
	1    2950 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 1250 2950 1250
Wire Wire Line
	2950 1250 2950 1350
Connection ~ 2650 1250
Wire Wire Line
	2650 1050 2950 1050
Wire Wire Line
	2950 1050 2950 950 
Connection ~ 2650 1050
$Comp
L Device:C_Small C2
U 1 1 5EC01695
P 900 2050
F 0 "C2" H 850 2250 50  0000 L CNN
F 1 "0.1uF" H 850 1850 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 900 2050 50  0001 C CNN
F 3 "~" H 900 2050 50  0001 C CNN
F 4 "Bypass caps" H 900 2050 50  0001 C CNN "Description"
	1    900  2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C5
U 1 1 5EC0169B
P 1150 2050
F 0 "C5" H 1100 2250 50  0000 L CNN
F 1 "0.1uF" H 1100 1850 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1150 2050 50  0001 C CNN
F 3 "~" H 1150 2050 50  0001 C CNN
F 4 "Bypass caps" H 1150 2050 50  0001 C CNN "Description"
	1    1150 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C8
U 1 1 5EC016A1
P 1400 2050
F 0 "C8" H 1350 2250 50  0000 L CNN
F 1 "0.1uF" H 1350 1850 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1400 2050 50  0001 C CNN
F 3 "~" H 1400 2050 50  0001 C CNN
F 4 "Bypass caps" H 1400 2050 50  0001 C CNN "Description"
	1    1400 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C11
U 1 1 5EC016A7
P 1650 2050
F 0 "C11" H 1600 2250 50  0000 L CNN
F 1 "0.1uF" H 1600 1850 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1650 2050 50  0001 C CNN
F 3 "~" H 1650 2050 50  0001 C CNN
F 4 "Bypass caps" H 1650 2050 50  0001 C CNN "Description"
	1    1650 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C14
U 1 1 5EC016AD
P 1900 2050
F 0 "C14" H 1850 2250 50  0000 L CNN
F 1 "0.1uF" H 1850 1850 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1900 2050 50  0001 C CNN
F 3 "~" H 1900 2050 50  0001 C CNN
F 4 "Bypass caps" H 1900 2050 50  0001 C CNN "Description"
	1    1900 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C17
U 1 1 5EC016B3
P 2150 2050
F 0 "C17" H 2100 2250 50  0000 L CNN
F 1 "0.1uF" H 2100 1850 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2150 2050 50  0001 C CNN
F 3 "~" H 2150 2050 50  0001 C CNN
F 4 "Bypass caps" H 2150 2050 50  0001 C CNN "Description"
	1    2150 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C20
U 1 1 5EC016B9
P 2400 2050
F 0 "C20" H 2350 2250 50  0000 L CNN
F 1 "0.1uF" H 2350 1850 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2400 2050 50  0001 C CNN
F 3 "~" H 2400 2050 50  0001 C CNN
F 4 "Bypass caps" H 2400 2050 50  0001 C CNN "Description"
	1    2400 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C23
U 1 1 5EC016BF
P 2650 2050
F 0 "C23" H 2600 2250 50  0000 L CNN
F 1 "0.1uF" H 2600 1850 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2650 2050 50  0001 C CNN
F 3 "~" H 2650 2050 50  0001 C CNN
F 4 "Bypass caps" H 2650 2050 50  0001 C CNN "Description"
	1    2650 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	900  1950 1150 1950
Wire Wire Line
	1150 1950 1400 1950
Connection ~ 1150 1950
Wire Wire Line
	1400 1950 1650 1950
Connection ~ 1400 1950
Wire Wire Line
	1650 1950 1900 1950
Connection ~ 1650 1950
Wire Wire Line
	1900 1950 2150 1950
Connection ~ 1900 1950
Wire Wire Line
	2150 1950 2400 1950
Connection ~ 2150 1950
Wire Wire Line
	2400 1950 2650 1950
Connection ~ 2400 1950
Wire Wire Line
	900  2150 1150 2150
Wire Wire Line
	1150 2150 1400 2150
Connection ~ 1150 2150
Wire Wire Line
	1400 2150 1650 2150
Connection ~ 1400 2150
Wire Wire Line
	1650 2150 1900 2150
Connection ~ 1650 2150
Wire Wire Line
	2150 2150 1900 2150
Connection ~ 1900 2150
Wire Wire Line
	2150 2150 2400 2150
Connection ~ 2150 2150
Wire Wire Line
	2400 2150 2650 2150
Connection ~ 2400 2150
$Comp
L power:VCC #PWR05
U 1 1 5EC016E3
P 2950 1850
F 0 "#PWR05" H 2950 1700 50  0001 C CNN
F 1 "VCC" H 2967 2023 50  0000 C CNN
F 2 "" H 2950 1850 50  0001 C CNN
F 3 "" H 2950 1850 50  0001 C CNN
	1    2950 1850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5EC016E9
P 2950 2250
F 0 "#PWR06" H 2950 2000 50  0001 C CNN
F 1 "GND" H 2955 2077 50  0000 C CNN
F 2 "" H 2950 2250 50  0001 C CNN
F 3 "" H 2950 2250 50  0001 C CNN
	1    2950 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 2150 2950 2150
Wire Wire Line
	2950 2150 2950 2250
Connection ~ 2650 2150
Wire Wire Line
	2650 1950 2950 1950
Wire Wire Line
	2950 1950 2950 1850
Connection ~ 2650 1950
$Comp
L Device:C_Small C3
U 1 1 5EC0564C
P 900 2950
F 0 "C3" H 850 3150 50  0000 L CNN
F 1 "0.1uF" H 850 2750 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 900 2950 50  0001 C CNN
F 3 "~" H 900 2950 50  0001 C CNN
F 4 "Bypass caps" H 900 2950 50  0001 C CNN "Description"
	1    900  2950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C6
U 1 1 5EC05652
P 1150 2950
F 0 "C6" H 1100 3150 50  0000 L CNN
F 1 "0.1uF" H 1100 2750 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1150 2950 50  0001 C CNN
F 3 "~" H 1150 2950 50  0001 C CNN
F 4 "Bypass caps" H 1150 2950 50  0001 C CNN "Description"
	1    1150 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C9
U 1 1 5EC05658
P 1400 2950
F 0 "C9" H 1350 3150 50  0000 L CNN
F 1 "0.1uF" H 1350 2750 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1400 2950 50  0001 C CNN
F 3 "~" H 1400 2950 50  0001 C CNN
F 4 "Bypass caps" H 1400 2950 50  0001 C CNN "Description"
	1    1400 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C12
U 1 1 5EC0565E
P 1650 2950
F 0 "C12" H 1600 3150 50  0000 L CNN
F 1 "0.1uF" H 1600 2750 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1650 2950 50  0001 C CNN
F 3 "~" H 1650 2950 50  0001 C CNN
F 4 "Bypass caps" H 1650 2950 50  0001 C CNN "Description"
	1    1650 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C15
U 1 1 5EC05664
P 1900 2950
F 0 "C15" H 1850 3150 50  0000 L CNN
F 1 "0.1uF" H 1850 2750 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1900 2950 50  0001 C CNN
F 3 "~" H 1900 2950 50  0001 C CNN
F 4 "Bypass caps" H 1900 2950 50  0001 C CNN "Description"
	1    1900 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C18
U 1 1 5EC0566A
P 2150 2950
F 0 "C18" H 2100 3150 50  0000 L CNN
F 1 "0.1uF" H 2100 2750 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2150 2950 50  0001 C CNN
F 3 "~" H 2150 2950 50  0001 C CNN
F 4 "Bypass caps" H 2150 2950 50  0001 C CNN "Description"
	1    2150 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C21
U 1 1 5EC05670
P 2400 2950
F 0 "C21" H 2350 3150 50  0000 L CNN
F 1 "0.1uF" H 2350 2750 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2400 2950 50  0001 C CNN
F 3 "~" H 2400 2950 50  0001 C CNN
F 4 "Bypass caps" H 2400 2950 50  0001 C CNN "Description"
	1    2400 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	900  2850 1150 2850
Wire Wire Line
	1150 2850 1400 2850
Connection ~ 1150 2850
Wire Wire Line
	1400 2850 1650 2850
Connection ~ 1400 2850
Wire Wire Line
	1650 2850 1900 2850
Connection ~ 1650 2850
Wire Wire Line
	1900 2850 2150 2850
Connection ~ 1900 2850
Wire Wire Line
	2150 2850 2400 2850
Connection ~ 2150 2850
Connection ~ 2400 2850
Wire Wire Line
	900  3050 1150 3050
Wire Wire Line
	1150 3050 1400 3050
Connection ~ 1150 3050
Wire Wire Line
	1400 3050 1650 3050
Connection ~ 1400 3050
Wire Wire Line
	1650 3050 1900 3050
Connection ~ 1650 3050
Wire Wire Line
	2150 3050 1900 3050
Connection ~ 1900 3050
Wire Wire Line
	2150 3050 2400 3050
Connection ~ 2150 3050
Connection ~ 2400 3050
$Comp
L power:VCC #PWR07
U 1 1 5EC0569A
P 3350 2750
F 0 "#PWR07" H 3350 2600 50  0001 C CNN
F 1 "VCC" H 3367 2923 50  0000 C CNN
F 2 "" H 3350 2750 50  0001 C CNN
F 3 "" H 3350 2750 50  0001 C CNN
	1    3350 2750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5EC056A0
P 3350 3200
F 0 "#PWR08" H 3350 2950 50  0001 C CNN
F 1 "GND" H 3355 3027 50  0000 C CNN
F 2 "" H 3350 3200 50  0001 C CNN
F 3 "" H 3350 3200 50  0001 C CNN
	1    3350 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 3050 3350 3200
$Comp
L 74LS593:QX14T50B1.843200B50TT U26
U 1 1 5EC08E25
P 8750 2250
F 0 "U26" H 9350 2515 50  0000 C CNN
F 1 "ECS-100AX-035" H 9350 2424 50  0000 C CNN
F 2 "Oscillator:Oscillator_DIP-14" H 9800 2350 50  0001 L CNN
F 3 "http://docs-emea.rs-online.com/webdocs/127f/0900766b8127fc57.pdf" H 9800 2250 50  0001 L CNN
F 4 "Oscillator" H 9800 2150 50  0001 L CNN "Description"
F 5 "Qantek" H 9800 1950 50  0001 L CNN "Manufacturer_Name"
F 6 "QX14T50B1.843200B50TT" H 9800 1850 50  0001 L CNN "Manufacturer_Part_Number"
F 7 "1735868" H 9800 1550 50  0001 L CNN "RS Part Number"
F 8 "http://uk.rs-online.com/web/p/products/1735868" H 9800 1450 50  0001 L CNN "RS Price/Stock"
F 9 "70418025" H 9800 1350 50  0001 L CNN "Allied_Number"
F 10 "http://www.alliedelec.com/qantek-qx14t50b18-43200b50tt/70418025/" H 9800 1250 50  0001 L CNN "Allied Price/Stock"
	1    8750 2250
	1    0    0    -1  
$EndComp
NoConn ~ 8750 2250
$Comp
L power:GND #PWR09
U 1 1 5EC0C0E1
P 8600 2600
F 0 "#PWR09" H 8600 2350 50  0001 C CNN
F 1 "GND" H 8605 2427 50  0000 C CNN
F 2 "" H 8600 2600 50  0001 C CNN
F 3 "" H 8600 2600 50  0001 C CNN
	1    8600 2600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR010
U 1 1 5EC0C59F
P 10100 2100
F 0 "#PWR010" H 10100 1950 50  0001 C CNN
F 1 "VCC" H 10117 2273 50  0000 C CNN
F 2 "" H 10100 2100 50  0001 C CNN
F 3 "" H 10100 2100 50  0001 C CNN
	1    10100 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	10100 2100 10100 2350
Wire Wire Line
	10100 2350 9950 2350
Wire Wire Line
	8750 2350 8600 2350
Wire Wire Line
	8600 2350 8600 2550
Wire Wire Line
	9950 2250 10150 2250
$Comp
L Connector:Conn_01x10_Female J1
U 1 1 5EC2788F
P 1800 4950
F 0 "J1" H 1650 5650 50  0000 L CNN
F 1 "Data Bus Pin Header" H 1350 5550 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x10_P2.54mm_Vertical" H 1800 4950 50  0001 C CNN
F 3 "~" H 1800 4950 50  0001 C CNN
F 4 "Data Bus Pin Header" H 1800 4950 50  0001 C CNN "Description"
	1    1800 4950
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x18_Female J2
U 1 1 5EC28ECF
P 3200 5350
F 0 "J2" H 3000 6450 50  0000 L CNN
F 1 "Address Bus Pin Header" H 2650 6350 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x18_P2.54mm_Vertical" H 3200 5350 50  0001 C CNN
F 3 "~" H 3200 5350 50  0001 C CNN
F 4 "Address Bus Pin Header" H 3200 5350 50  0001 C CNN "Description"
	1    3200 5350
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x06_Female J3
U 1 1 5EC2A66D
P 4250 4750
F 0 "J3" H 4100 5250 50  0000 L CNN
F 1 "uSeq Pin Header" H 3800 5150 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 4250 4750 50  0001 C CNN
F 3 "~" H 4250 4750 50  0001 C CNN
F 4 "uSeq Pin Header" H 4250 4750 50  0001 C CNN "Description"
	1    4250 4750
	1    0    0    -1  
$EndComp
Entry Wire Line
	1150 4650 1250 4550
Wire Wire Line
	1250 4550 1600 4550
Entry Wire Line
	1150 4750 1250 4650
Entry Wire Line
	1250 4750 1150 4850
Entry Wire Line
	1150 4950 1250 4850
Entry Wire Line
	1150 5050 1250 4950
Entry Wire Line
	1150 5150 1250 5050
Entry Wire Line
	1150 5250 1250 5150
Entry Wire Line
	1150 5350 1250 5250
Entry Wire Line
	2550 4650 2650 4550
Entry Wire Line
	2550 4750 2650 4650
Entry Wire Line
	2550 4850 2650 4750
Entry Wire Line
	2550 4950 2650 4850
Entry Wire Line
	2550 5050 2650 4950
Entry Wire Line
	2550 5150 2650 5050
Entry Wire Line
	2550 5250 2650 5150
Entry Wire Line
	2550 5350 2650 5250
Entry Wire Line
	2550 5450 2650 5350
Entry Wire Line
	2550 5550 2650 5450
Entry Wire Line
	2550 5650 2650 5550
Entry Wire Line
	2550 5750 2650 5650
Entry Wire Line
	2550 5850 2650 5750
Entry Wire Line
	2550 5950 2650 5850
Entry Wire Line
	2550 6050 2650 5950
Entry Wire Line
	2550 6150 2650 6050
Entry Wire Line
	3600 4650 3700 4550
Entry Wire Line
	3600 4750 3700 4650
Entry Wire Line
	3600 4850 3700 4750
Entry Wire Line
	3600 4950 3700 4850
Wire Wire Line
	1250 4650 1600 4650
Wire Wire Line
	1250 4750 1600 4750
Wire Wire Line
	1250 4850 1600 4850
Wire Wire Line
	1250 4950 1600 4950
Wire Wire Line
	1250 5050 1600 5050
Wire Wire Line
	1250 5150 1600 5150
Wire Wire Line
	1250 5250 1600 5250
Wire Wire Line
	2650 4550 3000 4550
Wire Wire Line
	2650 4650 3000 4650
Wire Wire Line
	2650 4750 3000 4750
Wire Wire Line
	2650 4850 3000 4850
Wire Wire Line
	2650 4950 3000 4950
Wire Wire Line
	2650 5050 3000 5050
Wire Wire Line
	2650 5150 3000 5150
Wire Wire Line
	3000 5250 2650 5250
Wire Wire Line
	2650 5350 3000 5350
Wire Wire Line
	3000 5450 2650 5450
Wire Wire Line
	2650 5550 3000 5550
Wire Wire Line
	3000 5650 2650 5650
Wire Wire Line
	2650 5750 3000 5750
Wire Wire Line
	3000 5850 2650 5850
Wire Wire Line
	2650 5950 3000 5950
Wire Wire Line
	3000 6050 2650 6050
Wire Wire Line
	4050 4850 3700 4850
Wire Wire Line
	3700 4750 4050 4750
Wire Wire Line
	3700 4650 4050 4650
Wire Wire Line
	4050 4550 3700 4550
$Comp
L power:GND #PWR0148
U 1 1 5ECAE549
P 1450 5500
F 0 "#PWR0148" H 1450 5250 50  0001 C CNN
F 1 "GND" H 1455 5327 50  0000 C CNN
F 2 "" H 1450 5500 50  0001 C CNN
F 3 "" H 1450 5500 50  0001 C CNN
	1    1450 5500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0149
U 1 1 5ECB2283
P 3850 5100
F 0 "#PWR0149" H 3850 4850 50  0001 C CNN
F 1 "GND" H 3855 4927 50  0000 C CNN
F 2 "" H 3850 5100 50  0001 C CNN
F 3 "" H 3850 5100 50  0001 C CNN
	1    3850 5100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0150
U 1 1 5ECB33A1
P 2750 6300
F 0 "#PWR0150" H 2750 6050 50  0001 C CNN
F 1 "GND" H 2755 6127 50  0000 C CNN
F 2 "" H 2750 6300 50  0001 C CNN
F 3 "" H 2750 6300 50  0001 C CNN
	1    2750 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 5450 1450 5450
Wire Wire Line
	1450 5450 1450 5500
Wire Wire Line
	4050 5050 3850 5050
Wire Wire Line
	3850 5050 3850 5100
Wire Wire Line
	3000 6250 2750 6250
Wire Wire Line
	2750 6250 2750 6300
Text GLabel 1000 5850 0    50   Input ~ 0
d[0..7]
Wire Bus Line
	1000 5850 1150 5850
Text Label 1350 4550 0    50   ~ 0
d0
Text Label 1350 4650 0    50   ~ 0
d1
Text Label 1350 4750 0    50   ~ 0
d2
Text Label 1350 4850 0    50   ~ 0
d3
Text Label 1350 4950 0    50   ~ 0
d4
Text Label 1350 5050 0    50   ~ 0
d5
Text Label 1350 5150 0    50   ~ 0
d6
Text Label 1350 5250 0    50   ~ 0
d7
Text GLabel 2400 6550 0    50   Input ~ 0
adr[0..15]
Wire Bus Line
	2400 6550 2550 6550
Text Label 2700 4550 0    50   ~ 0
adr0
Text Label 2700 4650 0    50   ~ 0
adr1
Text Label 2700 4750 0    50   ~ 0
adr2
Text Label 2700 4850 0    50   ~ 0
adr3
Text Label 2700 4950 0    50   ~ 0
adr4
Text Label 2700 5050 0    50   ~ 0
adr5
Text Label 2700 5150 0    50   ~ 0
adr6
Text Label 2700 5250 0    50   ~ 0
adr7
Text Label 2700 5350 0    50   ~ 0
adr8
Text Label 2700 5450 0    50   ~ 0
adr9
Text Label 2700 5550 0    50   ~ 0
adr10
Text Label 2700 5650 0    50   ~ 0
adr11
Text Label 2700 5750 0    50   ~ 0
adr12
Text Label 2700 5850 0    50   ~ 0
adr13
Text Label 2700 5950 0    50   ~ 0
adr14
Text Label 2700 6050 0    50   ~ 0
adr15
Text Label 3750 4550 0    50   ~ 0
seq0
Text Label 3750 4650 0    50   ~ 0
seq1
Text Label 3750 4750 0    50   ~ 0
seq2
Text Label 3750 4850 0    50   ~ 0
seq3
Text GLabel 3800 5550 2    50   Input ~ 0
seq[0..3]
Wire Bus Line
	3600 5550 3800 5550
$Comp
L power:GND #PWR012
U 1 1 5ED5E533
P 8250 4050
F 0 "#PWR012" H 8250 3800 50  0001 C CNN
F 1 "GND" H 8250 3900 50  0000 C CNN
F 2 "" H 8250 4050 50  0001 C CNN
F 3 "" H 8250 4050 50  0001 C CNN
	1    8250 4050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR011
U 1 1 5ED5E988
P 8250 3150
F 0 "#PWR011" H 8250 3000 50  0001 C CNN
F 1 "VCC" H 8267 3323 50  0000 C CNN
F 2 "" H 8250 3150 50  0001 C CNN
F 3 "" H 8250 3150 50  0001 C CNN
	1    8250 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 3150 8250 3400
Wire Wire Line
	8250 3600 8250 3950
Connection ~ 2900 2850
Connection ~ 2900 3050
$Comp
L Device:CP_Small C25
U 1 1 5ED86267
P 2900 2950
F 0 "C25" H 2850 3150 50  0000 L CNN
F 1 "220uF" H 2850 2750 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D8.0mm_P5.00mm" H 2900 2950 50  0001 C CNN
F 3 "~" H 2900 2950 50  0001 C CNN
F 4 "Power cap" H 2900 2950 50  0001 C CNN "Description"
	1    2900 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C26
U 1 1 5EBD4842
P 2650 2950
F 0 "C26" H 2600 3150 50  0000 L CNN
F 1 "0.1uF" H 2600 2750 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2650 2950 50  0001 C CNN
F 3 "~" H 2650 2950 50  0001 C CNN
F 4 "Bypass caps" H 2650 2950 50  0001 C CNN "Description"
	1    2650 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 2750 3350 2850
$Comp
L 74xx:74LS139 U21
U 3 1 5EC2E33A
P 9400 5400
F 0 "U21" H 9630 5446 50  0000 L CNN
F 1 "74HCT139" H 9630 5355 50  0000 L CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 9400 5400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS139" H 9400 5400 50  0001 C CNN
	3    9400 5400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0151
U 1 1 5EC2F49D
P 9400 6000
F 0 "#PWR0151" H 9400 5750 50  0001 C CNN
F 1 "GND" H 9405 5827 50  0000 C CNN
F 2 "" H 9400 6000 50  0001 C CNN
F 3 "" H 9400 6000 50  0001 C CNN
	1    9400 6000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0152
U 1 1 5EC314CB
P 9400 4800
F 0 "#PWR0152" H 9400 4650 50  0001 C CNN
F 1 "VCC" H 9417 4973 50  0000 C CNN
F 2 "" H 9400 4800 50  0001 C CNN
F 3 "" H 9400 4800 50  0001 C CNN
	1    9400 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 4800 9400 4900
Wire Wire Line
	9400 5900 9400 6000
$Comp
L DS1233:DS1233-10+ IC1
U 1 1 5EBEBA54
P 8250 3400
F 0 "IC1" H 8600 3650 50  0000 L CNN
F 1 "DS1233-10+" H 8450 3550 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92" H 9000 3500 50  0001 L CNN
F 3 "http://docs-emea.rs-online.com/webdocs/0a29/0900766b80a2926b.pdf" H 9000 3400 50  0001 L CNN
F 4 "Reset Device" H 9000 3300 50  0001 L CNN "Description"
F 5 "" H 9000 3200 50  0001 L CNN "Height"
F 6 "Maxim Integrated" H 9000 3100 50  0001 L CNN "Manufacturer_Name"
F 7 "DS1233-10+" H 9000 3000 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "700-DS1233-10" H 9000 2900 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=700-DS1233-10" H 9000 2800 50  0001 L CNN "Mouser Price/Stock"
F 10 "1901547P" H 9000 2700 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/1901547P" H 9000 2600 50  0001 L CNN "RS Price/Stock"
	1    8250 3400
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C27
U 1 1 5EC0E441
P 9150 3750
F 0 "C27" H 9242 3796 50  0000 L CNN
F 1 "0.01uF" H 9242 3705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9150 3750 50  0001 C CNN
F 3 "~" H 9150 3750 50  0001 C CNN
	1    9150 3750
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 5EC0EA9A
P 10000 3750
F 0 "SW1" V 9954 3898 50  0000 L CNN
F 1 "SW_Push" V 10045 3898 50  0000 L CNN
F 2 "Button_Switch_THT:Push_E-Switch_KS01Q01" H 10000 3950 50  0001 C CNN
F 3 "" H 10000 3950 50  0001 C CNN
F 4 "Reset button" H 10000 3750 50  0001 C CNN "Description"
	1    10000 3750
	0    1    1    0   
$EndComp
Wire Wire Line
	10000 3550 10000 3500
Connection ~ 10000 3500
Wire Wire Line
	10000 3500 10200 3500
Wire Wire Line
	9150 3650 9150 3500
Wire Wire Line
	9150 3850 9150 3950
Wire Wire Line
	9150 3950 8250 3950
Connection ~ 8250 3950
Wire Wire Line
	8250 3950 8250 4050
Text Notes 7150 2400 0    50   ~ 0
A 3.57MHz oscillator generates\nthe main clock pulse.
Text Notes 6550 3700 0    50   ~ 0
The DS1233 holds down the ~Reset\nline until power settles. The pushbutton\nallows for a manual reset.
Text Notes 8300 5500 0    50   ~ 0
The power section\nfor U21
Text Notes 3500 1750 0    50   ~ 0
These are the bypass caps\nfor all the ICs, plus a large\ncap for the power supply.
Text Notes 1800 7000 0    50   ~ 0
These three pin headers allow the\naddress bus, data bus and microsequence\nvalue to be examined by external equipment.
Text Notes 7100 6750 0    50   ~ 0
Miscellaneous components in the design.
Text GLabel 5400 6000 2    50   Input ~ 0
ALUop0
Text GLabel 5400 5900 2    50   Input ~ 0
ALUop1
Text GLabel 5400 5800 2    50   Input ~ 0
ALUop2
Text GLabel 5400 5700 2    50   Input ~ 0
ALUop3
Text GLabel 5500 4500 2    50   Input ~ 0
~uSreset
Text GLabel 5500 5600 2    50   Input ~ 0
DbWr0
Text GLabel 5500 5500 2    50   Input ~ 0
DbWr1
Text GLabel 5500 5400 2    50   Input ~ 0
DbWr2
Text GLabel 5400 5300 2    50   Input ~ 0
AbWr0
Text GLabel 5400 5200 2    50   Input ~ 0
AbWr1
Text GLabel 5500 5100 2    50   Input ~ 0
DbRd0
Text GLabel 5500 5000 2    50   Input ~ 0
DbRd1
Text GLabel 5500 4900 2    50   Input ~ 0
DbRd2
Text GLabel 5500 4800 2    50   Input ~ 0
DbRd3
Text GLabel 5400 4700 2    50   Input ~ 0
StkOp0
Text GLabel 5400 4600 2    50   Input ~ 0
StkOp1
$Comp
L Connector:Conn_01x18_Female J4
U 1 1 5EC4317E
P 5000 5400
F 0 "J4" H 4650 4250 50  0000 L CNN
F 1 "Control Lines Pin Header" H 4150 4350 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x18_P2.54mm_Vertical" H 5000 5400 50  0001 C CNN
F 3 "~" H 5000 5400 50  0001 C CNN
F 4 "Address Bus Pin Header" H 5000 5400 50  0001 C CNN "Description"
	1    5000 5400
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR013
U 1 1 5EC4E2AD
P 5400 6200
F 0 "#PWR013" H 5400 5950 50  0001 C CNN
F 1 "GND" H 5405 6027 50  0000 C CNN
F 2 "" H 5400 6200 50  0001 C CNN
F 3 "" H 5400 6200 50  0001 C CNN
	1    5400 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 6200 5400 6200
Wire Wire Line
	5200 6000 5400 6000
Wire Wire Line
	5200 5900 5400 5900
Wire Wire Line
	5400 5800 5200 5800
Wire Wire Line
	5200 5700 5400 5700
Wire Wire Line
	5500 5600 5200 5600
Wire Wire Line
	5200 5500 5500 5500
Wire Wire Line
	5500 5400 5200 5400
Wire Wire Line
	5200 5300 5400 5300
Wire Wire Line
	5400 5200 5200 5200
Wire Wire Line
	5200 5100 5500 5100
Wire Wire Line
	5500 5000 5200 5000
Wire Wire Line
	5200 4900 5500 4900
Wire Wire Line
	5500 4800 5200 4800
Wire Wire Line
	5200 4700 5400 4700
Wire Wire Line
	5400 4600 5200 4600
Wire Wire Line
	5200 4500 5500 4500
$Comp
L Connector:Conn_01x02_Female J5
U 1 1 5ECB0836
P 10450 2450
F 0 "J5" H 10300 2250 50  0000 L CNN
F 1 "Clock Pin Header" H 10050 2150 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x02_P2.54mm_Vertical" H 10450 2450 50  0001 C CNN
F 3 "~" H 10450 2450 50  0001 C CNN
F 4 "Clock Pin Header" H 10450 2450 50  0001 C CNN "Description"
	1    10450 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 3500 9550 3500
Connection ~ 9150 3500
Wire Wire Line
	9150 3950 9550 3950
Connection ~ 9150 3950
Wire Wire Line
	9550 3700 9550 3500
Connection ~ 9550 3500
Wire Wire Line
	9550 3500 10000 3500
Wire Wire Line
	9550 3800 9550 3950
Connection ~ 9550 3950
Wire Wire Line
	9550 3950 10000 3950
Wire Wire Line
	2400 2850 2650 2850
Wire Wire Line
	2400 3050 2650 3050
Connection ~ 2650 2850
Wire Wire Line
	2650 2850 2900 2850
Connection ~ 2650 3050
Wire Wire Line
	2650 3050 2900 3050
Wire Wire Line
	2900 2850 3350 2850
Wire Wire Line
	2900 3050 3350 3050
Wire Wire Line
	10150 2250 10150 2450
Wire Wire Line
	10150 2450 10250 2450
Connection ~ 10150 2250
Wire Wire Line
	10150 2250 10250 2250
Wire Wire Line
	10250 2550 8600 2550
Connection ~ 8600 2550
Wire Wire Line
	8600 2550 8600 2600
$Comp
L power:VCC #PWR0153
U 1 1 5ED4A434
P 850 5300
F 0 "#PWR0153" H 850 5150 50  0001 C CNN
F 1 "VCC" H 867 5473 50  0000 C CNN
F 2 "" H 850 5300 50  0001 C CNN
F 3 "" H 850 5300 50  0001 C CNN
	1    850  5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 5350 1250 5350
Wire Wire Line
	1250 5350 1250 5400
Wire Wire Line
	1250 5400 850  5400
Wire Wire Line
	850  5400 850  5300
$Comp
L power:VCC #PWR0154
U 1 1 5ED54DCD
P 2350 6150
F 0 "#PWR0154" H 2350 6000 50  0001 C CNN
F 1 "VCC" H 2367 6323 50  0000 C CNN
F 2 "" H 2350 6150 50  0001 C CNN
F 3 "" H 2350 6150 50  0001 C CNN
	1    2350 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 6150 2700 6150
Wire Wire Line
	2700 6150 2700 6200
Wire Wire Line
	2700 6200 2350 6200
Wire Wire Line
	2350 6200 2350 6150
$Comp
L power:VCC #PWR0155
U 1 1 5ED5C94F
P 3450 4950
F 0 "#PWR0155" H 3450 4800 50  0001 C CNN
F 1 "VCC" H 3467 5123 50  0000 C CNN
F 2 "" H 3450 4950 50  0001 C CNN
F 3 "" H 3450 4950 50  0001 C CNN
	1    3450 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 4950 3700 4950
Wire Wire Line
	3700 4950 3700 5000
Wire Wire Line
	3700 5000 3450 5000
Wire Wire Line
	3450 5000 3450 4950
$Comp
L power:VCC #PWR0156
U 1 1 5ED65C52
P 5950 6050
F 0 "#PWR0156" H 5950 5900 50  0001 C CNN
F 1 "VCC" H 5967 6223 50  0000 C CNN
F 2 "" H 5950 6050 50  0001 C CNN
F 3 "" H 5950 6050 50  0001 C CNN
	1    5950 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 6100 5950 6100
Wire Wire Line
	5950 6100 5950 6050
Wire Bus Line
	3600 4650 3600 5550
Wire Bus Line
	1150 4650 1150 5850
Wire Bus Line
	2550 4650 2550 6550
$EndSCHEMATC
