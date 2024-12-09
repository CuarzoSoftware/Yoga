%global basever 3.2.0
%global origrel 1
%global somajor 3

Name:           cuarzo-yoga
Version:        %{basever}%{?origrel:_%{origrel}}
Release:        1%{?dist}
Summary:        Yoga is an embeddable layout engine targeting web standards. 

License:        MIT
URL:            https://github.com/facebook/yoga

BuildRequires:  git
BuildRequires:  tar
BuildRequires:  wget
BuildRequires:  gcc-c++
BuildRequires:  cmake

%description
Yoga is an embeddable layout engine targeting web standards. 

%package        devel
Summary:        Development files for %{name}
Requires:       %{name}%{?_isa} = %{version}-%{release}

%description    devel
The %{name}-devel package contains libraries and header files for
developing applications that use %{name}.

%prep
rm -rf src
rm -f src.tar.gz
mkdir -p src
wget -O src.tar.gz %{url}/archive/refs/tags/v%{basever}.tar.gz
tar --strip-components=1 -xzvf src.tar.gz -C src

%build
pushd src
%cmake
%cmake_build
popd

%install
pushd src
%cmake_install
popd

%files
%license src/LICENSE
%doc src/README.md
%{_libdir}/libyogacore.a

%files devel
%{_includedir}/yoga/
%{_libdir}/cmake/yoga/

%changelog
* Mon Dec 09 2024 Eduardo Hopperdietzel <ehopperdietzel@gmail.com> - %{basever}-%{origrel}
- First release.
