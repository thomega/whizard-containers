FROM thomega/whizard_build_env:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
########################################################################

ENV HEPMC HepMC-2.06.09
ENV LHAPDF LHAPDF-6.1.5

########################################################################
# These should have already been set by whizard_build_env 
USER whizard
WORKDIR /home/whizard

########################################################################
RUN mkdir src
WORKDIR src

########################################################################
# HepMC
########################################################################

RUN wgetx http://lcgapp.cern.ch/project/simu/HepMC/download/$HEPMC.tar.gz
RUN tar xzf $HEPMC.tar.gz
WORKDIR $HEPMC
RUN ./configure --with-momentum=GEV --with-length=MM
RUN make -j `getconf _NPROCESSORS_ONLN`
RUN make check
USER root
RUN make install
RUN ldconfig
USER whizard
WORKDIR /home/whizard/src
RUN rm -fr $HEPMC

########################################################################
# LHAPDF
########################################################################

USER root
RUN apt-get install --no-install-recommends -qy python-dev libboost-dev

USER whizard
RUN wgetx http://www.hepforge.org/archive/lhapdf/$LHAPDF.tar.gz
RUN tar xzf $LHAPDF.tar.gz
WORKDIR $LHAPDF
RUN ./configure
RUN make -j `getconf _NPROCESSORS_ONLN`
USER root
RUN make install
RUN ldconfig
RUN lhapdf install cteq6l1 CT10
USER whizard
WORKDIR /home/whizard/src
RUN rm -fr $LHAPDF

########################################################################
WORKDIR /home/whizard
