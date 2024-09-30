;*****************************************************************
;* This stationery serves as the framework for a                 *
;* user application (single file, absolute assembly application) *
;* For a more comprehensive program that                         *
;* demonstrates the more advanced functionality of this          *
;* processor, please see the demonstration applications          *
;* located in the examples subdirectory of the                   *
;* Author: Saheer Multani                                        *
;*****************************************************************

; export symbols
            XDEF Entry, _Startup              ; export 'Entry' symbol
            ABSENTRY Entry                    ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc'
		
;**************************************************************
;*                 Writing to the LCD                         *
;************************************************************** 
		
; Definitions
LCD_DAT       EQU   PTS                       ; LCD data port S,  pins PS7,PS6,PS5,PS4
LCD_CNTR      EQU   PORTE                     ; LCD control Port E, pins PE7(RS),PE4(E)
LCD_E         EQU   $10                       ; LCD enable signal, pin PE4
LCD_RS        EQU   $80                       ; LCD reset signal, pin PE7
		
		
; code section
              ORG   $4000

Entry:
_Startup:
              LDS   #$4000                    ; initialize stack pointer
              JSR   initLCD                   ; initialize LCD
              
;**************************************************************
;*                 Program Starts Here                        *
;************************************************************** 

MainLoop      JSR   clrLCD                    ; clear LCD & home cursor
              
              LDX                             ; display msg1  
              JSR   putsLCD                   ; -"-
              
              LDAA
              JSR   leftHLF
              STAA
              
              LDAA
              JSR   rightHLF
              STAA
              
              LDAA
              JSR
              STAA
              
              LDAA
              JSR
              STAA
              
              LDAA
              STAA
              
              LDX   #mem1
              JSR   putsLCD
              
              LDY   #
              JSR   del_50us
              BRA   MainLoop
              
msg1          dc.b  "Hi There! ",0

;subroutine section

;*******************************************************************
;* Initialization of the LCD: 4-bit data width, 2-line display,    *
;* turn on display, cursor and blinking off. Shift cursor right.   *
;*******************************************************************

initLCD       BSET  DDRS,%11110000
              BSET  DDRE,%
              LDY   #2000
              JSR   del_50us
              LDAA  #$28
              JSR   cmd2LCD
              LDAA  #$0C
              JSR   cmd2LCD
              LDAA  #$06
              JSR   cmd2LCD
              RTS
              
;*******************************************************************
;* Clear display and home cursor                                   *
;*******************************************************************

clrLCD        LDAA  #$01
              JSR   cmd2LCD
              LDY   #40
              JSR   del_50us
              RTS
              
;*******************************************************************
;* ([Y] x 50us -delay subroutine. E-clk=41,67ns                    *
;*******************************************************************

del_50us:     PSHX
eloop:        LDX   #30
iloop:        PSHA
              PULA
              
              PSHA
              PULA
              NOP
              NOP
              DBNE  X,iloop
              DBNE  Y,eloop
              PULX
              RTS
              
;*******************************************************************
;* This function sends a command in accumulator A to the LCD       *
;*******************************************************************

cmd2LCD:      BCLR  LCD_CNTR,LCD_RS
              JSR   dataMov
              RTS
              
;*******************************************************************
;* This function ouputs a NULL-terminated string pointed to by X   *
;*******************************************************************

putsLCD       LDAA  1,X+
              BEQ   donePS
              JSR   putcLCD
              BRA   putsLCD
donePS        RTS

;*******************************************************************
;* This function ouputs the character in accumulator in A to LCD   *
;*******************************************************************

putcLCD       BSET  LCD_CNTR,LCD_RS
              JSR   dataMov
              RTS
              
;*******************************************************************
;* This function sends data to the LCD IR or DR depending on RS    *
;*******************************************************************

DataMov       BSET  LCD_CNTR,LCD_E
              STAA  LCD_DAT
              BCLR  LCD_CNTR,LCD_E
              
              LSLA
              LSLA
              LSLA
              LSLA
              
              BSET  LCD_CNTR,LCD_E
              STAA  LCD_DAT
              BCLR  LCD_CNTR,LCD_E
              
              LDY   #1
              JSR   del_50us
              RTS
              
;*******************************************************************
;* Binary to ASCII                                                 *
;*******************************************************************

leftHLF       LSRA
              LSRA
              LSRA
              LSRA
rightHLF      ANDA  #$0F
              CMPA  #$30
              BLE   out
              ADDA  #$07
out           RTS

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
              ORG   $FFFE
              DC.W  Entry                     ; Reset Vector
