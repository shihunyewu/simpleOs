; haribote-os
; TAB=4

; �L?BOOT_INFO
CYLS	EQU		0x0ff0			; ?��??��
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; ?��?�F���ړI�M��
SCRNX	EQU		0x0ff4			; �������IX
SCRNY	EQU		0x0ff6			; �������IY
VRAM	EQU		0x0ff8			; ?��?�t��I?�n�n��

		ORG		0xc200			; �������v�푕?���I�����ʒu

		MOV		AL,0x13			; VGA??�C320X200X8�ʍʐF
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; ???�ʖ͎�
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

; �pBIOS�擾??��e?LED�w�����I��?

		MOV		AH,0x02
		INT		0x16 			; keyboard BIOS
		MOV		[LEDS],AL

fin:
		HLT
		JMP		fin
