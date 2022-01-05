;Von Reinhard Richter aus dem Kurs Prozessrechner und Elektronik

	processor	PIC16F84A
	include		p16f84a.inc
	
;Configurationword*******************************************************
	__CONFIG _CP_OFF & _XT_OSC & _WDT_OFF & _PWRTE_ON ;config: 0x3ff1


;INITIALISIERUNG*********************************************************
 org 0x000	;schreibe den nächsten Befehl an die Speicherstelle 0x000
 
	bsf	STATUS,RP0		;BANK1
	clrf	TRISA			;PORTA als AUSGANG
	clrf	TRISB			;PORTB als AUSGANG
	bcf	OPTION_REG,PSA		;Prescaler auf TMR0
	bsf	OPTION_REG,PS0		;
	bsf	OPTION_REG,PS1		;Prescaler auf 1:256
	bsf	OPTION_REG,PS2		;
	bcf	OPTION_REG,T0CS		;Internal Clock
	bcf	STATUS,RP0		;BANK0
	
	clrf	PORTA			;PORTA löschen
	clrf	PORTB			;PORTB löschen
	movlw	0x01			;00000001 in W
	movwf	0x0C			;lade W in Register 0x0C
							;0x0C ist die erste Speicherzelle
							;im RAM, die nicht von einem SFR
							;verwendet wird
	bcf	STATUS, C			;lösche das Carry-Bit

;HAUPTPROGRAMM***********************************************************
MAIN
	movf	0x0C,W			;Lade den Inhalt von Register 0x0C nach W
	movwf	PORTA			;Kopiere W nach PORTA
	movwf	PORTB			;Kopiere W nach PORTB
	call	delay			;warte etwas
	rlf	0x0C,f				;Rotiere 0x0C nach links

	goto MAIN				;Schleife

;Delayschleife***********************************************************
delay
	clrf	TMR0			;lösche TMR0
	bcf	INTCON,T0IF			;TMR0 overflow interrupt flag
							;löschen
delay_loop
	btfss	INTCON,T0IF		;springe wenn T0IF gesetzt
	goto	delay_loop			
	return
	
 end

;Beschreibung: In den grünen und gelben LEDs wird ein "Lauflicht" erzeugt, d.h.
;Takt für Takt leuchtet eine andere LED auf. 