TOOLPATH = ../simpleOsSourceCode/tolset/z_tools/
MAKE	=$(TOOLPATH)make.exe
NASK	=$(TOOLPATH)nask.exe
EDIMG	=$(TOOLPATH)edimg.exe
IMGTOL	=$(TOOLPATH)imgtol.exe

sgyos.img:ipl.bin Makefile
	$(EDIMG) imgin:../simpleOsSourceCode/tolset/z_tools/fdimg0at.tek   \
	wbinimg src:ipl.bin len:512 from:0 to:0   imgout:sgyos.img

ipl.bin: ipl.nas Makefile
	$(NASK) ipl.nas ipl.bin ipl.lst

clean:
	del ipl.bin
	del ipl.lst

src_only:
	$(MAKE) clean
	del sgyos.img
	del sss.txt