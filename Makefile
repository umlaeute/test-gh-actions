
!include <win32.mak>

all: test.exe

.c.obj:
	$(cc) $(cdebug) $(cflags) $(cvars) $*.c

test.exe: test.obj
	$(link) $(ldebug) $(conflags) -out:test.exe test.obj $(conlibs) lsapi32.lib

