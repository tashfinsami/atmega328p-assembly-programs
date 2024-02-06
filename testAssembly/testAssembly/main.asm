.include "m328pdef.inc"  ; Include the ATmega328P definition file

.def LED_MASK = r16
.def TEST_MASK = r20

.equ LED_PIN = PB1
.equ TEST_PIN = PB5

ldi LED_MASK, (1 << LED_PIN)
com LED_MASK
clr r17
in r17, DDRB
and r17, LED_MASK
out DDRB, r17

ldi TEST_MASK, (1 << TEST_PIN)
clr r17
in r17, DDRB
or r17, TEST_MASK
out DDRB, r17

ldi LED_MASK, (1 << LED_PIN)
clr r17
in r17, PORTB
or r17, LED_MASK
out PORTB, r17


main_loop:

	ldi LED_MASK, (1 << LED_PIN)
	clr r17
	in r17, PINB
	and r17, LED_MASK
	tst r17
	brne LED_SET

	ldi TEST_MASK, (1 << TEST_PIN)
	com TEST_MASK
	clr r17
	in r17, PORTB
	and r17, TEST_MASK
	out PORTB, r17

	rjmp main_loop

	LED_SET:
		ldi TEST_MASK, (1 << TEST_PIN)
		clr r17
		in r17, PORTB
		or r17, TEST_MASK
		out PORTB, r17
	
		rjmp main_loop       ; Infinite loop to keep the LED on
