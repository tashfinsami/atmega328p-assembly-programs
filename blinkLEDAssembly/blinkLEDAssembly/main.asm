.include "m328pdef.inc"  ; ATmega328P definition file

.equ LED_PIN = PB1

ldi r16, (1 << LED_PIN)    ; load the bitmask for LED pin in register r16

.macro custom_delay 
	ldi r17, @0
	delay_loop0:
	ldi r18, 250
	inner_loop1:
		ldi r19, 250
		inner_loop2:
			dec r19
			brne inner_loop2
		dec r18
		brne inner_loop1
    dec r17             
    brne delay_loop0
.endmacro


main_loop:
    sbi PORTB, LED_PIN      ; set PORTB register to turn on LED

    custom_delay 64

    cbi PORTB, LED_PIN      ; clear PORTB register to turn off LED
    
	custom_delay 64

    rjmp main_loop      ; jump back to the main loop
