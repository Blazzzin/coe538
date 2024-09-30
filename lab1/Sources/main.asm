;******************************************************************
;*      Demonstration Program                                     *
;*                                                                *
;* This program illustrates how to use the assembler.             *
;* It multiplies together two 8 bit numbers and leaves the result *
;* in the 'PRODUCT' location.                                     *
;* Author: Saheer Multani                                         *
;******************************************************************

; export symbols
            XDEF Entry, _Startup      ; export 'Entry' symbol
            ABSENTRY Entry            ; for absolute assembly: mark this as application entry point

; Include derivative-specific definitions 
		INCLUDE 'derivative.inc'

;*****************************************************************
;* Code section                                                  *
;***************************************************************** 
                ORG  $3000            ; Store the variables inside the address 3000
            
            
MULTIPLICAND    FCB  02               ; First Number - It goes <name, type, value>
MULTIPLIER      FCB  03               ; Second Number - It goes <name, type, value>
PRODUCT         RMB  2                ; Result of product - It goes <name, type, # of bytes>

;*****************************************************************
;* The actual program starts here                                *
;*****************************************************************
            ORG   $4000               ; The instructions are stored inside the address 4000
       
Entry:
_Startup:
            LDAA MULTIPLICAND         ; Get the first number into ACCA (Register A, so 02 loads into Register A)
            LDAB MULTIPLIER           ; Second number into register B (03)
            MUL                       ; Multiplies the first 8 bit number from Register A and the second 8 bit number from register B and stores the 16 bit product in Register D
            STD PRODUCT               ; and store the product in Register D (Stores it in Product)
            SWI                       ; break to the monitor

;**************************************************************
;* Interrupt Vectors                                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry               ; Reset Vector
