#include <avr/io.h>

#define F_CPU 16000000UL
#include <util/delay.h>

#define LED_PIN PB1

void initIO() {
	// Set PB4 as output
	DDRB |= (1 << LED_PIN);
}

void turnOnLED() {
	// Set PB4 high to turn on the LED
	PORTB |= (1 << LED_PIN);
}

int main(void) {
	initIO(); // Initialize I/O ports
	//turnOnLED(); // Turn on the LED
	
	while (1) {
		// Your main code can go here
		
		// You can add additional code or keep the program running in a loop
		
		PORTB &= ~(1 << LED_PIN);
		
		_delay_ms(1000); // Delay for 1 second using the _delay_ms function from util/delay.h
		
		PORTB |= (1 << LED_PIN);
		
		_delay_ms(1000); // Delay for 1 second using the _delay_ms function from util/delay.h
		
	}
	
	return 0;
}
