; haribote-ipl
; TAB=4

; ??I?M§
		ORG		0x7c00			; φn¬
		JMP		entry
		DB		0x90
		DB		"HARIBOTE"		; 
		DW		512				; 
		DB		1				; 
		DW		1				; 
		DB		2				; 
		DW		224				; 
		DW		2880			; 
		DB		0xf0			; 
		DW		9				; 
		DW		18				; 
		DW		2				; 
		DD		0				; 
		DD		2880			; 
		DB		0,0,0x29		; 
		DD		0xffffffff		; 
		DB		"HARIBOTEOS "	; 
		DB		"FAT12   "		; 
		RESB	18				; 

; φεΜ

entry:
		MOV		AX,0			; ρΆνn»
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; ?Q??Iξζ

		MOV		AX,0x0820		;??₯0820H
		MOV		ES,AX
		MOV		CH,0			; Κ0
		MOV		DH,0			; ₯?0
		MOV		CL,2			; ξΚ2

		MOV		AH,0x02			; AH=0x02 : ??
		MOV		AL,1			; κ’ξζ
		MOV		BX,0
		MOV		DL,0x00			; gpA??ν
		INT		0x13			; ?p₯?BIOS
		JC		error


fin:
		HLT						; CPUβ~Hμ
		JMP		fin				; Ωΐz?
; ΊΚ₯o?M§
		
error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SIΊΪ
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; ?¦Ά
		MOV		BX,15			; Ά?F
		INT		0x10			; BIOSf
		JMP		putloop
msg:
		DB		0x0a, 0x0a		; ??s
		DB		"load error"
		DB		0x0a			; ?s
		DB		0

		RESB	0x7dfe-$		; Έ?έIn¬ΪA510IΚuU0

		DB		0x55, 0xaa		;??ζIΕ@?φ
