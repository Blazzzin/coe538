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
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 

; variable/data section

            ORG   $3850

; code section
            ORG   $4000


Entry:
_Startup:
Start       BSET  DDRA,%00000011              ; Appendix A - on/off is PortT and forw/rev is PortA
            BSET  DDRT,%00110000
            JSR   STARFWD
            JSR   PORTFWD
            JSR   STARON
            JSR   PORTON
            
            ;Add some delay (del_50us)
            
            ;JSR   STARREV
            ;JSR   PORTREV
            ;JSR   STAROFF
            ;JSR   PORTOFF
            
            ;Add some delay for the third routine
            ;LDY   #40000
            ;del50us
            
            BRA   Start
            
STARON      LDAA  PTT
            ORAA  #%00100000
            STAA  PTT
            RTS
            
STAROFF     LDAA  PTT
            ANDA  #%11011111
            STAA  PTT
            RTS
          
PORTFWD     LDAA  PORTA
            ANDA  #%11111110
            STAA  PORTA
            RTS
            
PORTREV     LDAA  PORTA
            ORAA  #%00000001
            STAA  PORTA
            RTS
            
STARFWD     LDAA  PORTA
            ANDA  #%11111101
            STAA  PORTA
            RTS
            
STARREV     LDAA  PORTA
            ORAA  #%00000010
            STAA  PORTA
            RTS
            
PORTON      LDAA  PTT
            ORAA  #%00100000
            STAA  PTT
            RTS
            
PORTOFF     LDAA  PTT
            ANDA  #%11011111
            STAA  PTT
            RTS
            
            
;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
