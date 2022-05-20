
CC = cl
LD = link

CFLAGS_BASE = /c /W2 /nologo
CFLAGS_DEBUG = /Zi /Od

DEFINES_BASE = /DWIN32 /DWIN64 /D_CRT_SECURE_NO_WARNINGS /D_CRT_SECURE_NO_DEPRECATE /D_CRT_NONSTDC_NO_DEPRECATE /D_CRT_NON_CONFORMING_SWPRINTFS
DEFINES_DEBUG =

LINKFLAGS_BASE = /NODEFAULTLIB /NOLOGO
LINKFLAGS_DEBUG = /DEBUG

ifeq ($(BUILD_TYPE),static)
  DEFINES   = $(DEFINES_BASE)
  CFLAGS    = $(CFLAGS_BASE) /MT
  LINKFLAGS = $(LINKFLAGS_BASE)
  CRTLIB    = libcmt.lib libvcruntime.lib libucrt.lib
  CUNITLIB  = static/libcunit_exe.lib

else ifeq ($(BUILD_TYPE),static_debug)
  DEFINES   = $(DEFINES_BASE) $(DEFINES_DEBUG)
  CFLAGS    = $(CFLAGS_BASE) $(CFLAGS_DEBUG) /MTd
  LINKFLAGS = $(LINKFLAGS_BASE) $(LINKFLAGS_DEBUG)
  CRTLIB    = libcmtd.lib libvcruntimed.lib libucrtd.lib
  CUNITLIB  = static/libcunitd_exe.lib

else
  $(error BUILD_TYPE=$(BUILD_TYPE) is not supported)
endif


INCLUDES = -I $(SOURCE) -I $(subst /,\,$(DIST)/include) -I $(subst /,\,$(INSTALL)include)
SOURCES = $(wildcard $(SOURCE)/*.cpp)
HEADERS = $(wildcard $(SOURCE)/*.h)

NAME = hello

all : $(DIST)/$(NAME).exe

$(DIST)/$(NAME).exe: $(SOURCES) $(HEADERS)
	echo kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib  >  $(NAME).link
	echo shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib       >> $(NAME).link
	echo $(CRTLIB)                                                                 >> $(NAME).link
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) $(SOURCES)
	$(LD) $(LINKFLAGS) *.obj @$(NAME).link -out:$(NAME).exe
	copy $(NAME).exe $(DIST)
	copy $(NAME).pdb $(DIST)

clean::
	-del /q * 2>nul


