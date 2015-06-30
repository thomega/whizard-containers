FROM thomega/whizard_build_env:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
LABEL \
  org.hepforge.whizard.image="build environment with HepMC and LHAPDF" \
  org.hepforge.whizard.hepmc.version="2.06.09" \
  org.hepforge.whizard.lhapdf.version="6.1.5"
########################################################################

WORKDIR /tmp

# Debian's HepMC is up-to-date
# Debian's LHAPDF is still at 5.9, 6.x needs Boost and python
DEBIAN_INSTALL([[libhepmc-dev libhepmcfio-dev python-dev libboost-dev]])
dnl BUILD_HEPMC([[2.06.09]])
BUILD_LHAPDF([[6.1.5]])
BUILD_HOPPET([[1.1.5]])
WORKDIR /home/whizard
