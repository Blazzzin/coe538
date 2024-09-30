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
            ABSENTRY Entry                  ; for absolute assembly: mark this as application entry point

; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 

; code section
             ORG   $4000
             
Entry:        
_Startup:
             BSET DDRH,%11111111
             STAA PTH                ; (P 6)
            
;**************************************************************************************************************************************************************************************

             ;BSET DDRE,%00010000    ; Configure pin PE4 for output (enable bit)
             ;BCLR PORTE,%00010000   ; Enable keypad
             ;LDAA PTS               ; Read a key code into AccA
             
             ; The code on top is a showing us how to use an actual serial monitor (P 4 & 5)

;**************************************************************************************************************************************************************************************

             ;LDAA PORTA            ; Load accumulator A with PORTA - PORTA is like an input on a circuit. For this simulation, the value at this port is 0
             ;ORAA #%00000001       ; Logical "OR" A with memory - % means binary. So basically 0 or 1 which is just 1
             ;STAA PORTA            ; Store accumalator A to memory
             
             ; The code on top is a displaying or statements (P 3.1)

;**************************************************************************************************************************************************************************************
            
;SHORT_DELAY: DECA                 ; Decrements A by 1 (P 2.5)
             ;BNE SHORT_DELAY      ; Branch if not equal to zero (P 2.5)
             ;RTS                  ; Return from the subroutine (P 2.5)
             
                                               
             ;LDAA #$05            ; Loads Accumlator A with 5
             ;JSR SHORT_DELAY      ; Jumps upto the subroutine "SHORT_DELAY" and keeps decrementing until it is 0 and then breaks
             
             ; The code on top is a loop with a break that decrements by 1 and follows a sub routine (P 2.5)
             
;**************************************************************************************************************************************************************************************           

             ;LDAA #$FF            ; Loads Accumlator A with #$FF (#$FF - # means the value is used directly isntead of referencing a memory address and $ means hexadecimal)
;LOOP         DECA                 ; Decrements A by 1
             ;NOP                  ; No Operation. Gives more execution time. A little delay.
             ;BNE LOOP             ; Branch if not equal to zero (the A accumulator) 
            
             ; The code on top is a single loop with a delay that decrements by 1 (P 2.1 & 2.2 & 2.3)
            
;**************************************************************************************************************************************************************************************            
            
             ;LDX #$FFFF            ; Loads Register X with $FFFF
             ;LDY #$FFFF            ; Loads Register Y with $FFFF
;OUT_LOOP:
;IN_LOOP:                          
             ;DEY                   ; Decrements Y by 1
             ;BNE IN_LOOP           ; Branch if not equal to zero
             ;DEX                   ; Decrements X by 1
             ;BNE OUT_LOOP          ; Branch if not equal to zero
            
             ; The code on top is a nested loop that decrements by 1. The inner loop consists of IN_LOOP, DEY and BNE IN_LOOP and the outer loop has OUTER_LOOP and everything below it (P 2.4)
            
;**************************************************************************************************************************************************************************************            
            
;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************

            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
