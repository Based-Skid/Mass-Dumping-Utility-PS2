#include <tamtypes.h>
#include <errno.h>
#include <kernel.h>
#include <sifrpc.h>
#include <loadfile.h>
#include <fileio.h>
#include <libmc.h>
#include <stdio.h>
#include <string.h>
#include "libpad.h"
#include <debug.h>
#include <libpwroff.h>
#include <iopcontrol.h>
#include <stdlib.h>
#include "malloc.h"
//#include <libcdvd.h>
#include <iopheap.h>
#include <io_common.h>
#include <syscallnr.h>
#include <sbv_patches.h>
#include <fileXio_rpc.h>
#include <malloc.h>
#include <sifcmd.h>
#include <timer.h>
#include <usbhdfsd-common.h>
#include <limits.h>
#include <sys/stat.h>
#include <sys/fcntl.h>
//MCTOOLS
#include "mctoolsrpc/mctools_rpc.h"
//Required For Multitap
#include "libmtap.h"
// SBV
#include <sbv_patches.h>

//IRX Modules
extern void mtapman;
extern void freesio2;
extern void iomanX;
extern void fileXio;
extern void freepad;
extern void poweroff;
extern void mcman;
extern void mcserv;
extern void MCTOOLS_irx;
extern void USBD;
extern void USBHDFSD;
//
extern u32 size_mtapman;
extern u32 size_poweroff;
extern u32 size_freesio2;
extern u32 size_iomanX;
extern u32 size_fileXio;
extern u32 size_freepad;
extern u32 size_mcman;
extern u32 size_mcserv;
extern u32 size_MCTOOLS_irx;
extern u32 size_USBD;
extern u32 size_USBHDFSD;

//PAD VARIABLES
//check for multiple definitions
#define DEBUG

#if !defined(ROM_PADMAN) && !defined(NEW_PADMAN)
#define ROM_PADMAN
#endif

#if defined(ROM_PADMAN) && defined(NEW_PADMAN)
#error Only one of ROM_PADMAN & NEW_PADMAN should be defined!
#endif

#if !defined(ROM_PADMAN) && !defined(NEW_PADMAN)
#error ROM_PADMAN or NEW_PADMAN must be defined!
#endif


//pad buffer
static char padBuf[256] __attribute__((aligned(64)));
//rumblers
static char actAlign[6];
static int actuators;
//button status
struct padButtonStatus buttons;
u32 paddata;
u32 old_pad;
u32 new_pad;
int port, slot;
extern void readPad(void);

void LoadModules(void);
void initialize(void);
int LoadIRX();
void gotoOSDSYS(int sc);
void ResetIOP();
void menu_Text(void);
void menu_header(void);

