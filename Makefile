VERSION  	 = 161209

prefix 	 	 = /usr/local
exec_prefix	 = $(prefix)
bindir		 = $(exec_prefix)/bin
datadir	 	 = $(prefix)/share
includedir 	 = $(prefix)/include
libdir 	 	 = $(exec_prefix)/lib
docdir 	 	 = $(datadir)/doc

INCLUDE	 	 = -I.

CC  	 	 ?= cc
FC 		 	 := $(if $(filter $(FC),f77),f95,$(FC))

CFLAGS 	 	 ?= -O3 -march=native -ffast-math -Wall
FFLAGS	 	 ?= -O3 -march=native -ffast-math -fstack-arrays -std=f2008 -Wall

ALL_CPPFLAGS = "-DVERSION=\"$(VERSION)\"" -DREALPRECISION=14 $(CPPFLAGS)
COMPILE.c 	 = $(CC) $(INCLUDE) $(ALL_CPPFLAGS) -g $(CFLAGS) -c
COMPILE.F    = $(FC) $(INCLUDE) $(ALL_CPPFLAGS) -g $(FFLAGS) -c
LINK.c 	 	 = $(CC) $(INCLUDE) $(ALL_CPPFLAGS) -g $(CFLAGS) $(LDFLAGS)
LINK.F    	 = $(FC) $(INCLUDE) $(ALL_CPPFLAGS) -g $(FFLAGS) $(LDFLAGS)
LINK.o       = $(LD) --build-id $(LDFLAGS)

all:  bin/evolenses

installdirs:
	install -d $(DESTDIR)$(bindir)

install: installdirs all
	install -p bin/* $(DESTDIR)$(bindir)

random.o: interpol.o

bin/%: %.F90 constants.o functions.o optsolv.o random.o interpol.o
	mkdir -p bin
	$(LINK.F) $^ -o $@

%.o: %.F90
	$(COMPILE.F) -c $< -o $@

clean:
	rm -rfv *.o *.mod *.a *.so *.so *.pc

distclean: clean
	rm -rfv evolenses-*
	rm -rfv x86_64 i686 .build*

dist: distclean
	tar cvf evolenses-$(VERSION).tar -C .. \
			--exclude='evolenses/.git' \
			--exclude='evolenses/*.tar' \
			--exclude='evolenses/bin' \
			--transform="s/^evolenses/evolenses-$(VERSION)/" \
			evolenses
	xz -f evolenses-$(VERSION).tar
