VERSION=0.1

prefix=/opt/evolenses
exec_prefix=$(prefix)
bindir=$(exec_prefix)/bin
datadir=$(prefix)/share
includedir=$(prefix)/include
libdir=$(exec_prefix)/lib
docdir=$(datadir)/doc/evolenses

CC := gcc
FC := gfortran

override ALL_CFLAGS = -I.
override ALL_FCFLAGS = -I.

# C compilers
ifeq ($(CC),gcc)
CFLAGS = -O3 -march=native -ffast-math
endif
ifeq ($(CC),icc)
CFLAGS = -O2 -xHost -unroll -ipo
endif

# Fortran compilers
ifeq ($(FC),gfortran)
override ALL_FCFLAGS += -std=f2008 -fimplicit-none -cpp
FCFLAGS = -O3 -march=native -ffast-math -fstack-arrays
endif
ifeq ($(FC),ifort)
override ALL_FCFLAGS += -implicitnone -cpp
FCFLAGS = -O2 -xHost -unroll -ipo
endif

override ALL_CFLAGS += $(CFLAGS)
override ALL_FCFLAGS += $(FCFLAGS)

all:  bin/evolenses

installdirs:
	install -d $(DESTDIR)$(bindir)

install: installdirs all
	install -p bin/* $(DESTDIR)$(bindir)

bin/evolenses: evolenses.F90
	mkdir -p bin
	$(FC) $(ALL_FCFLAGS) -o $@  $^

dist: distclean
	mkdir -p dist
	tar cf dist/evolenses-$(VERSION).tar ../evolenses \
			--exclude='.git' --exclude='.gitmodules' \
			--exclude='evolenses/dist' \
			--exclude='evolenses/rpmbuild'
	xz -f dist/evolenses-$(VERSION).tar

rpm: dist
	mkdir -p rpmbuild/SOURCES rpmbuild/SPECS rpmbuild/RPMS \
				rpmbuild/SRPMS rpmbuild/BUILD
	cp dist/evolenses-$(VERSION).tar.xz rpmbuild/SOURCES/
	cp evolenses.spec rpmbuild/SPECS
	cd rpmbuild/SPECS && rpmbuild \
			--define "_topdir $(CURDIR)/rpmbuild" \
			--define "_version $(VERSION)" \
			-ba evolenses.spec

clean:
	rm -f *.mod *.o

distclean: clean
	rm -rf bin
