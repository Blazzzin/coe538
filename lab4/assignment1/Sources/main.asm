;*****************************************************************
;* This code is for part 1 of lab 4 that controls the motor of   *
;* rover                                                         *
;* Author: Saheer Multani                                        *
;*****************************************************************

; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry                  ; for absolute assembly: mark this as application entry point

; Include derivative-specific definitions 
		        INCLUDE 'derivative.inc' 

; code section
            ORG   $4000

;*****************************************************************
;*                        Motor Control                          *
;*****************************************************************

Entry:
_Startup:
            BSET  DDRA,%00000011
            BSET  DDRT,%00110000
            JSR   STARFWD
            JSR   PORTFWD
            JSR   STARON
            JSR   PORTON
            JSR   STARREV
            JSR   PORTREV
            JSR   STAROFF
            JSR   PORTOFF
            BRA   *
            
STARON      LDAA  PTT
            ORAA  #%00100000                ; PT5 = 1 for ON
            STAA  PTT
            RTS
            
STAROFF     LDAA  PTT
            ANDA  #%11011111                ; PT5 = 0 for OFF
            STAA  PTT
            RTS
            
STARFWD     LDAA  PORTA
            ANDA  #%11111101                ; PA1 = 0 for FWD
            STAA  PORTA
            RTS
            
STARREV     LDAA  PORTA
            ORAA  #%00000010                ; PA1 = 1 for REV
            STAA  PORTA
            RTS
            
PORTON      LDAA  PTT
            ORAA  #%00010000                ; PT4 = 1 for ON
            STAA  PTT
            RTS
            
PORTOFF     LDAA  PTT
            ANDA  #%11101111                ; PT4 = 0 for OFF      
            STAA  PTT
            RTS
            
PORTFWD     LDAA  PORTA
            ANDA  #%11111110                ; PA0 = 0 for FWD
            STAA  PORTA
            RTS
            
PORTREV     LDAA  PORTA
            ORAA  #%00000001                ; PA0 = 1 for REV 
            STAA  PORTA
            RTS           


;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry                     ; Reset Vector
