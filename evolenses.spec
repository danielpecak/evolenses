Name:           evolenses
Version:        161209
Release:        1%{?dist}
Summary:        Evolution of Lenses

License:        Unknown
URL:            https://github.com/danielpecak/evolenses
Source:         evolenses-%{version}.tar.xz

BuildRequires:  gcc gcc-gfortran
Requires:       libgfortran glibc

%description
Genetic algorithm for breeding small telescopes.

%prep
%autosetup

%build
make    VERSION="%{version}" \
        DESTDIR="$RPM_BUILD_ROOT" \
        prefix="%{_prefix}" \
        bindir="%{_bindir}"  \
        libdir="%{_libdir}"  \
        includedir="%{_includedir}" \
        datadir="%{_datadir}" \
        docdir="%{_docdir}"

%install
rm -rf $RPM_BUILD_ROOT
make install VERSION="%{version}" \
        DESTDIR="$RPM_BUILD_ROOT" \
        prefix="%{_prefix}" \
        bindir="%{_bindir}"  \
        libdir="%{_libdir}"  \
        includedir="%{_includedir}" \
        datadir="%{_datadir}" \
        docdir="%{_docdir}"

%files
#%license LICENSE
%{_bindir}/*
#%{_docdir}/evolenses/*


%changelog
* Fri Dec  9 2016 gronki <gronki@gmail.com>
- First version
