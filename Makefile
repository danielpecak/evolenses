VERSION  	 	= 170106

prefix 	 	 	= /usr/local
exec_prefix	 	= $(prefix)
bindir		 	= $(exec_prefix)/bin
datadir	 	 	= $(prefix)/share
includedir 	 	= $(prefix)/include
libdir 	 	 	= $(exec_prefix)/lib
fmoddir			= $(libdir)/finclude
docdir 	 	 	= $(datadir)/doc
licensedir 	 	= $(datadir)/licenses

INCLUDE	 	 	= -I.

CC  	 	 	:= cc
CFLAGS 	 	 	?= -g -Wall -O3 -march=native
FC 		 	 	:= f95 -fimplicit-none -std=f2008
FFLAGS	 	 	?= -g -Wall -O3 -march=native
FPP				:= cpp -traditional -nostdinc

COMPILE.C    	= $(CC) $(INCLUDE) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
COMPILE.F    	= $(FC) $(INCLUDE) $(FFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
LINK.C    	 	= $(CC) $(INCLUDE) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
LINK.F    	 	= $(FC) $(INCLUDE) $(FFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)

all:  bin/evolenses

installdirs:
	install -d $(DESTDIR)$(bindir)

install: installdirs all
	install -p bin/* $(DESTDIR)$(bindir)

random.o: interpol.o

bin/%: %.F90 functions.o random.o interpol.o
	mkdir -p bin
	$(LINK.F) $^ -o $@

testbin/%: tests/%.F90 functions.o
	mkdir -p testbin
	$(LINK.F) $^ -o $@

tests: testbin/test_ray testbin/test_secondMoment

%.o: %.F90
	$(COMPILE.F) $< -o $@

tex: $(wildcard tex/*.tex)
	$(MAKE) -C tex

clean:
	rm -rfv *.o *.mod *.a *.so *.pc
	rm -rfv bin testbin

dist: clean
	tar cvf evolenses-$(VERSION).tar -C .. \
			--exclude='evolenses/.git' \
			--exclude='evolenses/*.tar' \
			--exclude='evolenses/*.tar.gz' \
			--transform="s/^evolenses/evolenses-$(VERSION)/" \
			evolenses
	gzip -f evolenses-$(VERSION).tar
