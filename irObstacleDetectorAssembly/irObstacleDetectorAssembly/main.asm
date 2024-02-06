.include "m328pdef.inc"  ; ATmega328P definition file

.def LED_MASK = r16
.def IR_MASK = r17 
.def BUZZER_MASK = r20
      
.equ IR_PIN = PB1
.equ LED_PIN = PB2 
.equ BUZZER_PIN = PB3

;configure ddrx for ir
ldi IR_MASK, (1 << IR_PIN)
com IR_MASK
clr r18
in r18, DDRB
and r18, IR_MASK
out DDRB, r18

;configure ddrx for led
ldi LED_MASK, (1 << LED_PIN)
clr r18
in r18, DDRB
or r18, LED_MASK
out DDRB, r18

;configure ddrx for buzzer
ldi BUZZER_MASK, (1 << BUZZER_PIN)
clr r18
in r18, DDRB
or r18, BUZZER_MASK
out DDRB, r18

;configure PORTx for ir to start
ldi IR_MASK, (1 << IR_PIN)
clr r18
in r18, PORTB
or r18, IR_MASK
out PORTB, r18

main_loop:
	;check ir value
	clr r19
	in r19, PINB
	ldi IR_MASK, (1 << IR_PIN)
	and r19, IR_MASK
	tst r19
	breq bit_set //active low ir sensor, 1 if low, 0 if high

	;no bit set
	;configure PORTx for led to stop
	ldi LED_MASK, (1 << LED_PIN)
	com LED_MASK
	clr r18
	in r18, PORTB
	and r18, LED_MASK
	out PORTB, r18

	;configure PORTx for buzzer to stop
	ldi BUZZER_MASK, (1 << BUZZER_PIN)
	com BUZZER_MASK
	clr r18
	in r18, PORTB
	and r18, BUZZER_MASK
	out PORTB, r18

	rjmp main_loop

	;bit set
	bit_set:
			;configure PORTx for led to start
			ldi LED_MASK, (1 << LED_PIN)
			clr r18
			in r18, PORTB
			or r18, LED_MASK
			out PORTB, r18	

			;configure PORTx for buzzer to start
			ldi BUZZER_MASK, (1 << BUZZER_PIN)
			clr r18
			in r18, PORTB
			or r18, BUZZER_MASK
			out PORTB, r18	

    rjmp main_loop       ; Infinite loop to keep the LED on
