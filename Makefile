sgyos.img:ipl.bin Makefile
	..\simpleOsSourceCode\tolset\z_tools\edimg.exe   imgin:../simpleOsSourceCode/tolset/z_tools/fdimg0at.tek   wbinimg src:ipl.bin len:512 from:0 to:0   imgout:sgyos.img

ipl.bin: ipl.nas Makefile
	..\simpleOsSourceCode\tolset\z_tools\nask.exe ipl.nas ipl.bin ipl.lst
	mkdir Ido

clean:
	-del ipl.bin
	-del ipl.lst
	if exist Ido make Idotoo 

src_only:
	../z_tools/make.exe clean
	-del helloos.img