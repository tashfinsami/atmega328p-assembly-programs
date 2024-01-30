#include <avr/io.h>

#define F_CPU 16000000UL  
#include <util/delay.h>

#define IR_SENSOR_PIN PB1
#define BUZZER_PIN PB3
#define LED_PIN PB2

void initIO() {
	// Configure IR sensor
	DDRB &= ~(1 << IR_SENSOR_PIN);

	// Configure buzzer pin and LED pins
	DDRB |= (1 << BUZZER_PIN) | (1 << LED_PIN);

	
	PORTB |= (1 << IR_SENSOR_PIN);
}

int main() {
	initIO();

	while (1) {
		// Check if obstacle is detected
		if (PINB & (1 << IR_SENSOR_PIN)) {
			
			PORTB &= ~((1 << LED_PIN) | (1 << BUZZER_PIN));
			 _delay_ms(500);  
			} else {
			// obstacle detected
			PORTB |= (1 << LED_PIN) | (1 << BUZZER_PIN);
			 _delay_ms(500); 
		}
	}

	return 0;
}
