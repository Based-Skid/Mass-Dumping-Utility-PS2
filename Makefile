EE_BIN = mDU.elf
EE_BIN_PACKED = mDU-packed.elf
IRX_DIR = irx/compiled


# C File
EE_OBJS = main.o mtaphelper.o
# SW Module
EE_OBJS += freesio2.o iomanX.o fileXio.o freepad.o mcman.o mcsrv.o USBD.o USBHDFSD.o freemtap.o
#MCTOOLS
EE_OBJS += MCTOOLS_irx.o mctoolsrpc/mctools_rpc.o
# Other IRX
EE_OBJS += poweroff.o
EE_INCS = -I$(PS2SDK)/ports/include -I$(PS2SDK)/sbv/include -I$(PS2SDK)/common/include -I./irx/source/mctools/src/
EE_LDFLAGS = -L$(PS2SDK)/sbv/lib 
EE_LIBS = -lpadx -lmtap -ldebug -lmc -lc -lpatches -ldebug -lkernel -lpoweroff -lfileXio -lmtap

all: $(EE_BIN)
	rm -rf *.o *.s

clean:
	rm -f *.elf *.o *.s
	
#poweroff Module
poweroff.s:
	bin2s $(PS2SDK)/iop/irx/poweroff.irx poweroff.s poweroff

#IRX Modules
freemtap.s:
	bin2s $(PS2SDK)/iop/irx/freemtap.irx freemtap.s mtapman
	
freesio2.s:
	bin2s $(PS2SDK)/iop/irx/freesio2.irx freesio2.s freesio2
iomanX.s:
	bin2s $(PS2SDK)/iop/irx/iomanX.irx iomanX.s iomanX
fileXio.s:
	bin2s $(PS2SDK)/iop/irx/fileXio.irx fileXio.s fileXio
freepad.s:
	bin2s $(PS2SDK)/iop/irx/freepad.irx freepad.s freepad
	
mcman.s:
	bin2s $(PS2SDK)/iop/irx/mcman.irx mcman.s mcman
mcsrv.s:
	bin2s $(PS2SDK)/iop/irx/mcserv.irx mcsrv.s mcserv
MCTOOLS_irx.s: $(IRX_DIR)/mctools.irx
	bin2s $(IRX_DIR)/mctools.irx MCTOOLS_irx.s MCTOOLS_irx
	
USBD.s: $(PS2SDK)/iop/irx/usbd.irx
	bin2s $(PS2SDK)/iop/irx/usbd.irx USBD.s USBD
USBHDFSD.s: $(PS2SDK)/iop/irx/usbhdfsd.irx
	bin2s $(PS2SDK)/iop/irx/usbhdfsd.irx USBHDFSD.s USBHDFSD
	
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal