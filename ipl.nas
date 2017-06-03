; haribote-ipl
; TAB=4

; ??的?部信息
		ORG		0x7c00			; 程序地址
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

; 程序主体

entry:
		MOV		AX,0			; 寄存器初始化
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; ?找??的扇区

		MOV		AX,0x0820		;??是0820？
		MOV		ES,AX
		MOV		CH,0			; 柱面0
		MOV		DH,0			; 磁?0
		MOV		CL,2			; 扇面2

		MOV		AH,0x02			; AH=0x02 : ??
		MOV		AL,1			; 一个扇区
		MOV		BX,0
		MOV		DL,0x00			; 使用A??器
		INT		0x13			; ?用磁?BIOS
		JC		error


fin:
		HLT						; CPU停止工作
		JMP		fin				; 无限循?
; 下面是出?信息
		
error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI下移
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; ?示文字
		MOV		BX,15			; 文字?色
		INT		0x10			; BIOS中断
		JMP		putloop
msg:
		DB		0x0a, 0x0a		; ??行
		DB		"load error"
		DB		0x0a			; ?行
		DB		0

		RESB	0x7dfe-$		; 从?在的地址移植到510的位置填0

		DB		0x55, 0xaa		;??区的最后?尾字符
