FROM thomega/whizard_build_env:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
LABEL \
  org.hepforge.whizard.image="build environment with HepMC and LHAPDF" \
  org.hepforge.whizard.hepmc.version="2.06.09" \
  org.hepforge.whizard.lhapdf.version="6.1.5"
########################################################################

ENV HEPMC HepMC-2.06.09
ENV LHAPDF LHAPDF-6.1.5

########################################################################
WORKDIR /tmp

########################################################################
# HepMC
########################################################################

RUN \
  wgetx http://lcgapp.cern.ch/project/simu/HepMC/download/$HEPMC.tar.gz && \
  tar xzf $HEPMC.tar.gz && \
  cd $HEPMC && \
  ./configure --with-momentum=GEV --with-length=MM && \
  make -j `getconf _NPROCESSORS_ONLN` && \
  make check && \
  make install && \
  ldconfig && \
  cd .. && \
  rm -fr $HEPMC

########################################################################
# LHAPDF
########################################################################

RUN apt-get install --no-install-recommends -qy \
      python-dev libboost-dev && apt-get clean

RUN \
  wgetx http://www.hepforge.org/archive/lhapdf/$LHAPDF.tar.gz && \
  tar xzf $LHAPDF.tar.gz && \
  cd $LHAPDF && \
  ./configure && \
  make -j `getconf _NPROCESSORS_ONLN` && \
  make install && \
  ldconfig && \
  lhapdf install cteq6l1 CT10 && \
  cd .. && \
  rm -fr $LHAPDF

########################################################################
WORKDIR /home/whizard
