# xlsh - eXtended Login Shell
# See COPYING file for license details.

.DEFAULT_GOAL = all
.PHONY: all install install-strip installdirs uninstall clean

prefix = /usr

exec_prefix = $(prefix)
bindir     = $(exec_prefix)/bin

SHELL = /bin/sh
INSTALL = install
INSTALL_DIR = $(INSTALL) -d
INSTALL_DATA = $(INSTALL) -m 644
INSTALL_PROGRAM = $(INSTALL)
INSTALL_PROGRAM_STRIP = $(INSTALL) -s

CMACROS = -D_POSIX_C_SOURCE=199309L -D_BSD_SOURCE
CFLAGS += -g -std=c99 -pedantic -Wall -Wcast-qual -Wpointer-arith -fstrict-aliasing
ALL_CFLAGS = -I./include $(CFLAGS) $(CMACROS)

.SUFFIXES:
.SUFFIXES: .o
vpath %.c ./src

PROGRAMS      = xlsh

XLSH_OBJ      = xlsh.o libxlsh.o
XLSH_SOURCE   = xlsh.c libxlsh.c
XLSH_HEADERS  = xlsh.h libxlsh.h config.h
XLSH_LIBS     = -lreadline -lpam

all: $(PROGRAMS)

xlsh: $(XLSH_OBJ)
xlsh: LDLIBS=$(XLSH_LIBS)

install: installdirs
	$(INSTALL_PROGRAM) xlsh $(DESTDIR)$(bindir)

install-strip: installdirs
	$(INSTALL_PROGRAM_STRIP) xlsh $(DESTDIR)$(bindir)

installdirs:
	$(INSTALL_DIR) $(DESTDIR)$(bindir)

uninstall:
	rm -f ${DESTDIR}$(bindir)/xlsh

clean:
	rm -f $(PROGRAMS)
	rm -f $(XLSH_OBJ)

%.o: %.c
	$(CC) -c $(CPPFLAGS) $(ALL_CFLAGS) $< -o $@
