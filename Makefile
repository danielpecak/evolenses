VERSION = 161205

prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
datadir = $(prefix)/share
includedir = $(prefix)/include
libdir = $(exec_prefix)/lib
docdir = $(datadir)/doc

FC := gfortran

FCFLAGS   = -g -O3
CPPFLAGS  =
INCLUDE   = -I.

override ALL_FCFLAGS   =
override ALL_CPPFLAGS  = -DVERSION="$(VERSION)" -Ddp="selected_real_kind(14)"

ifeq ($(FC),gfortran)
override ALL_FCFLAGS += -std=f2008 -fimplicit-none
FCFLAGS = -march=native -ffast-math -fstack-arrays
endif
ifeq ($(FC),ifort)
override ALL_FCFLAGS += -std08 -implicitnone
FCFLAGS = -xHost -ipo
endif

override ALL_CPPFLAGS 	+= $(INCLUDE) $(CPPFLAGS)
override ALL_FCFLAGS 	+= $(ALL_CPPFLAGS) $(FCFLAGS)

all:  bin/evolenses

installdirs:
	install -d $(DESTDIR)$(bindir)

install: installdirs all
	install -p bin/* $(DESTDIR)$(bindir)

random.o: interpol.o

bin/%: %.F90 constants.o functions.o optsolv.o random.o interpol.o
	mkdir -p bin
	$(FC) $(ALL_FCFLAGS) -o $@ $^

%.o: %.F90
	$(FC) $(ALL_FCFLAGS) -c -o $@ $<

dist: distclean
	mkdir -p dist
	tar cvf dist/evolenses-$(VERSION).tar -C .. \
			--exclude='evolenses/.git' \
			--exclude='evolenses/.gitmodules' \
			--exclude='evolenses/dist' \
			--exclude='evolenses/rpmbuild' \
			--transform="s/^evolenses/evolenses-$(VERSION)/" \
			evolenses
	xz -f dist/evolenses-$(VERSION).tar

clean:
	rm -f *.mod *.o

distclean: clean
	rm -rf bin
