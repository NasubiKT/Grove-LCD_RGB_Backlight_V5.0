10 '###################################
20 '# TITLE Sample Program
30 '#  for Grove-LCD RGB Backlight V5.0
40 '# Version 0.1.1 Update 20240201-1
50 '# LICENSE
60 '#  These codes are licensed under CC0.
70 '#  http://creativecommons.org/publicdomain/zero/1.0/deed.ja
80 '#  Nasubi-K.T is marked with CC0 1.0
90 '###################################
110 SCREEN 1,0,0
120 COLOR 15,4,7
130 WIDTH 32
140 KEY OFF
150 DEFINT A-Z
160 CLS
1000 '################################
1010 ' Constant Definition
1020 '################################
1100 '### For IoT
1110 TD$="device/i2c_a":'I2C Device Tree
1120 CL=&H80:'For LCD Command
1130 DL=&H40:'For LCD Data
1400 '################################
1410 ' Variable Definitions
1420 '################################
1500 '### For IoT
1510 IO=0:'IoT Flag(IO<1:IoT Disable)
1530 TL$="":'LCD Device Tree
1540 TB$="":'Backlight Device Tree
1550 DIM DS$(10)
1600 '### For Sub Routine
1610 IV=0:'Input Integer
1620 IS$="":'Input String
2000 '################################
2010 '# Initialize
2020 '################################
2100 '### IoT Initialize
2110 GOSUB 40100
2120 IF IO<1 THEN PRINT "IoT Disable."
2130 '###  Optional initialization
2140 'Set Char for CGRAM
2150 IV=0:'CGRAM CHR$(0)
2160 IS$="ptvwvtp "
2170 GOSUB 49000
3000 '################################
3010 '# Main Routine
3020 '################################
3100 'Set Cursor Position
3110 IV=&H80:'Cursor Position Address
3120 GOSUB 41000
3130 'Put String
3140 IS$=CHR$(0)+"IoT Enalbe."
3150 GOSUB 42000
3160 'Change backlight color randomly
3170 FOR I=0 TO 300:NEXT I
3180 IV=INT(RND(TIME)*256)
3190 C=INT(RND(TIME)*3)
3200 WS$=STR$(IV)+"  "
3210 'Setting for RED backlight
3220 IF C<>0 THEN 3280
3230 GOSUB 44000
3240 IV=&HC0
3250 GOSUB 41000
3260 IS$="Red  :"+WS$
3270 GOSUB 42000
3280 'Setting for GREEN backlight
3290 IF C<>1 THEN 3350
3300 GOSUB 45000
3310 IV=&HC0
3320 GOSUB 41000
3330 IS$="Green:"+WS$
3340 GOSUB 42000
3350 'Setting for BLUE backlight
3360 IF C<>2 THEN 3420
3370 GOSUB 46000
3380 IV=&HC0
3390 GOSUB 41000
3400 IS$="Blue :"+WS$
3410 GOSUB 42000
3420 PRINT IS$
3430 GOTO 3160
40000 '################################
40010 '# SUB Routine
40020 '################################
40100 '#############
40110 '# IoT Initialize
40120 '#  Input Values:N/A
40130 '#  Output Values
40140 '#   IO
40150 '#  Local Values
40160 '#   (IV IS$)
40190 '#############
40200 '### IoT Initialize
40210 ON ERROR GOTO 40260
40220 _IOTFIND(TD$,IO)
40230 IF IO<1 THEN 40270
40240 IF IO>10 THEN DIM DS$(IO)
40250 GOTO 40270
40260 RESUME 40270
40270 ON ERROR GOTO 0
40280 IF IO>0 THEN 40310
40290 'ELSE IoT is Disable.
40300 GOTO 40380
40310 'IoT is Enable.
40320 TL$=TD$+"/"+"3E"
40330 TB$=TD$+"/"+"30"
40340 '### LCD Initialize
40350 GOSUB 47000
40360 '### Backlight Initialize
40370 GOSUB 48000
40380 RETURN
41000 '#############
41010 '# LCD Send Command
41020 '#  Input Values
41030 '#   IV:Send Command
41040 '#  Output Values:N/A
41050 '#  Local Values
41060 '#   LS$
41070 '#############
41100 IF IO<1 THEN 41130
41110 LS$=CHR$(CL)+CHR$(IV)
41120 _IOTPUT(TL$,LS$)
41130 LS$=""
41140 RETURN
42000 '#############
42010 '# LCD Send Data
42020 '#  Input Values
42030 '#   IS$:Send Data
42040 '#  Output Values:N/A
42050 '#  Local Values
42060 '#   LS$
42070 '#############
42100 IF IO<1 THEN 42140
42110 IF LEN(IS$)<1 THEN 42140
42120 LS$=CHR$(DL)+IS$
42130 _IOTPUT(TL$,LS$)
42140 LS$=""
42150 RETURN
43000 '#############
43010 '# Backlight Send Data
43020 '#  Input Values
43030 '#   IS$:Send Data
43040 '#  Output Values:N/A
43050 '#  Local Values:N/A
43060 '#############
43100 IF IO<1 THEN 43130
43110 IF LEN(IS$)<1 THEN 43130
43120 _IOTPUT(TB$,IS$)
43130 RETURN
44000 '#############
44010 '# Backlight Set for RED
44020 '#  Input Values
44030 '#   IV:Red Value(0 to 255)
44040 '#  Output Values:N/A
44050 '#  Local Values
44060 '#   IS$
44070 '#############
44100 IF IO<1 THEN 44140
44110 IF IV<0 THEN 44140
44120 IS$=CHR$(&H6)+CHR$(IV)
44130 GOSUB 43000:'Backlight Send Data
44140 IS$=""
44150 RETURN
45000 '#############
45010 '# Backlight Set for GREEN
45020 '#  Input Values
45030 '#   IV:Green Value(0 to 255)
45040 '#  Output Values:N/A
45050 '#  Local Values
45060 '#   IS$
45070 '#############
45100 IF IO<1 THEN 45140
45110 IF IV<0 THEN 45140
45120 IS$=CHR$(&H7)+CHR$(IV)
45130 GOSUB 43000:'Backlight Send Data
45140 IS$=""
45150 RETURN
46000 '#############
46010 '# Backlight Set for BLUE
46020 '#  Input Values
46030 '#   IV:Blue Value(0 to 255)
46040 '#  Output Values:N/A
46050 '#  Local Values
46060 '#   IS$
46070 '#############
46100 IF IO<1 THEN 46140
46110 IF IV<0 THEN 46140
46120 IS$=CHR$(&H8)+CHR$(IV)
46130 GOSUB 43000:'Backlight Send Data
46140 IS$=""
46150 RETURN
47000 '#############
47010 '# LCD Inintialize
47020 '#   for Grove-LCD RGB Backlight V5.0
47030 '#  Input Values:N/A
47040 '#  Output Values:N/A
47050 '#  Local Values
47060 '#   IV
47070 '#############
47100 IF IO<1 THEN 47190
47110 IV=&H20+&H8:'LCD 2LINE
47120 GOSUB 41000:'Send Command
47130 IV=&H8+&H4:'Display On
47140 GOSUB 41000'Send Command
47150 IV=&H1:'Clear Display
47160 GOSUB 41000'Send Command
47170 IV=&H4+&H2:'Entry Left
47180 GOSUB 41000'Send Command
47190 RETURN
48000 '#############
48010 '# Backlight Initialize
48020 '#  for Grove-LCD RGB Backlight V5.0
48030 '#  Input Values:N/A
48040 '#  Output Values:N/A
48050 '#  Local Values
48060 '#   IS$
48070 '#############
48100 IF IO<1 THEN 48170
48110 'Backlight Chip Reset
48120 IS$=CHR$(&H0)+CHR$(&H7)
48130 GOSUB 43000:'Backlight Send Data
48140 'Backlight LED All On
48150 IS$=CHR$(&H4)+CHR$(&H15)
48160 GOSUB 43000:'Backlight Send Data
48170 IS$=""
48180 RETURN
49000 '#############
49010 '# Create Char
49020 '#  Input Values
49030 '#   IV:CGRAM Index(0 to 7)
49040 '#   IS$:Char Data(8bytes)
49050 '#  Output Values:N/A
49060 '# Local Values
49070 '#  AC CM IV (LS$ IS$)
49090 '#############
49100 IF IO<1 THEN 49190
49110 IF IV<0 OR IV>7 THEN 49190
49120 IF LEN(IS$)<>8 THEN 49190
49130 AC=IV AND &H7
49140 AC=AC*8
49150 CM=&H40+AC
49160 IV=CM
49170 GOSUB 41000:'Send Command
49180 GOSUB 42000:'Send Data
49190 RETURN
