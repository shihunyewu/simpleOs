; haribote-ipl
; TAB=4

; 软盘开头的定义
		ORG		0x7c00			; 
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

; 

entry:
		MOV		AX,0			; 
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; 读盘

		MOV		AX,0x0820		; 因为从0x8000往后的内存没有被提前占用
		MOV		ES,AX
		MOV		CH,0			; 柱面0
		MOV		DH,0			; 磁头0
		MOV		CL,2			; 扇区2
readloop:		
		MOV 	SI,0			; 记录尝试次数
retry:
		MOV		AH,0x02			; AH=0x02
		MOV		AL,1			; 1个扇区
		MOV		BX,0
		MOV		DL,0x00			; A驱动器
		INT		0x13			; 调用BIOS的中断
		JNC		next			; 如果没错跳到next
		ADD		SI,1			; 循环变量加一
		CMP		SI,5			;
		JAE		error			; 出错
	
		; 重置
		MOV		AH,0x00
		MOV		DL,0x00			;A驱动器
		INT 	0x13			;重置驱动器
		JMP		retry


next:
		MOV 	AX,ES			;将ES后移0x200，也就是下一个扇区
		ADD		AX,0x200		;
		MOV		EX,AX			;ES不能直接和数字进行操作
		ADD		CL,1			;读下一个扇区
		CMP		CL,18			;是否读到第18扇区
		JBE		readloop		;如果没有的话，继续读
fin:	
		HLT
		JMP		fin
; 显示出错信息
		
error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SI指针
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; 中断号
		MOV		BX,15			; 设置字体颜色
		INT		0x10			; BIOS中断
		JMP		putloop
msg:
		DB		0x0a, 0x0a		; 换行
		DB		"load error"
		DB		0x0a			; 换行
		DB		0

		RESB	0x7dfe-$		; 从这里到第511字节处置零

		DB		0x55, 0xaa		; 启动区结尾固有字节
