;hello-os
;TAB= 4
;以下这段是标准FAT12格式软盘专用的代码

ORG	0x7c00				;指明程序的装载地址
JMP	entry				;跳转到entry
DB	0x90
DB "HELLOIPL"			;启动区的名称可以是任意的字符串，但是只能是8字节
DB 512					
;每个扇区的大小必须为 512
;字节，因为计算机读写磁盘的时候是以512字节为一个单位进行读写，每512就是一个扇区，而启动区只能是第一个扇区
DB  1					;簇的大小，必须为 1 个扇区
DW  1					;FAT的起始位置一般是从第一个扇区开始，这里的DW可能是因为FAT12格式为这个字段分配了一个字的空间
DB  2					;FAT的个数为 2 ？为什么要为 2 ？
DW  224					;根目录大小一般设成224项
DW  2880				;该磁盘大小必须是2880
DB  0xf0				;磁盘的种类
DW	9					;FAT的长度，必须是9扇区
DW	18					;一个磁道有18个扇区
DW	2					;磁头数
DD  0					;不使用分区
DD  2880				;重写一次磁盘大小
DB  0,0,0x29			;意义不明，固定
DD  0xffffffff			;可能是卷标号码
DB  "HELLO-OS   "		;磁盘的名称,必须是11字节，不足补空格
DB  "FAT12   "			;磁盘格式名称，必须是8字节，不足补空格
RESB	18				;先空出18字节

entry:					;初始化寄存器的值

	MOV	AX,0			
	MOV SS,AX			
	MOV SP,0x7c00
	MOV DS,AX
	MOV ES,AX

	MOV SI,msg			;将输出字符串的存储位置赋给字符串偏移指针

putloop:				;依次输出字符程序段
	MOV AL,[SI]			;将SI指向的内存地址中的值赋给AL，其中AL存放的就是将要显示在屏幕上的字符
	ADD SI,1			;SI指向下一个内存地址
	CMP AL,0			;查看AL中的值是否为0，如果为0那么跳转到结束程序段
	JE  fin				
	MOV AH,0x0e			;显示一个文字，其中0x0e是该操作的中断号
	MOV BX,15			;指定字符颜色
	INT 0x10			;调用显卡BIOS
	JMP putloop			;接着循环putloop
fin:					;终止操作
		

	HLT					;让CPU停止，等待指令
	JMP fin				;跳转到fin
msg:					;定义数据
	DB 0x0a,0x0a		;两次换行
	DB "Hello,world,sgy";
	DB 0x0a
	DB 0
	
RESB	0x7dfe-$		; 将512B的空间填满0
DB		0x55, 0xaa		;最后设置成55aa，表示这是第一个启动模块