FROM thomega/whizard_build_env:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
LABEL \
  org.hepforge.whizard.image="build environment with HepMC and LHAPDF" \
  org.hepforge.whizard.hepmc.version="2.06.09" \
  org.hepforge.whizard.lhapdf.version="6.1.5"
########################################################################

RUN apt-get install --no-install-recommends -qy \
      python-dev libboost-dev && apt-get clean

WORKDIR /tmp
BUILD_HEPMC([[2.06.09]])
BUILD_LHAPDF([[6.1.5]])
WORKDIR /home/whizard
