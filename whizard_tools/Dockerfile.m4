FROM thomega/whizard_build_env:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
LABEL \
  org.hepforge.whizard.image="build environment with HepMC and LHAPDF" \
  org.hepforge.whizard.hepmc.version="2.06.09" \
  org.hepforge.whizard.lhapdf.version="6.1.5"
########################################################################

WORKDIR /tmp

# Debian's HepMC is up-to-date
DEBIAN_INSTALL([[libhepmc-dev libhepmcfio-dev]])
dnl BUILD_HEPMC([[2.06.09]])
# Debian's LHAPDF is still at 5.9, 6.x needs Boost and python
DEBIAN_INSTALL([[python-dev libboost-dev]])
BUILD_LHAPDF([[6.1.5]])
# Hoppet is simple
BUILD_HOPPET([[1.1.5]])
# LCIO builds from svn and requires Java.
DEBIAN_INSTALL([[subversion cmake default-jdk zlib1g-dev]])
dnl BUILD_LCIO([[v02-06]])
dnl BUILD_LCIO_LOCAL([[v02-06]])
dnl BUILD_LCIO_LOCAL([[v02-04-03]])
BUILD_LCIO_LOCAL([[2015-10-15]])
# Debian's FastJet is still at 3.0.6
dnl DEBIAN_INSTALL([[libfastjet-dev libfastjet-fortran-dev]])
BUILD_FASTJET([[3.1.2]])
BUILD_FASTJET_CONTRIB([[1.017]])
BUILD_STDHEP([[5-06-01]])
WORKDIR /home/whizard
