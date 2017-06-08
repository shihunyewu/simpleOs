TOOLPATH = ../simpleOsSourceCode/tolset/z_tools/
MAKE	=$(TOOLPATH)make.exe -r
NASK	=$(TOOLPATH)nask.exe
EDIMG	=$(TOOLPATH)edimg.exe
IMGTOL	=$(TOOLPATH)imgtol.exe
COPY     = copy
DEL      = del

default :
	$(MAKE) img

ipl10.bin: ipl10.nas Makefile
	$(NASK) ipl10.nas ipl10.bin ipl10.lst
sgyos.sys : sgyos.nas Makefile
	$(NASK) sgyos.nas sgyos.sys sgyos.lst

sgyos.img:ipl10.bin sgyos.sys Makefile
	$(EDIMG) imgin:../simpleOsSourceCode/tolset/z_tools/fdimg0at.tek   \
	wbinimg src:ipl10.bin len:512 from:0 to:0  \
	copy from:sgyos.sys to:@: \
	imgout:sgyos.img

img :
	$(MAKE) sgyos.img


install :
	$(MAKE) img
	$(IMGTOL) w a: sgyos.img
	
clean:
	-$(DEL) ipl10.bin
	-$(DEL) ipl10.lst
	-$(DEL) sgyos.sys
	-$(DEL) sgyos.lst
src_only:
	$(MAKE) clean
	-$(DEL) sgyos.img
