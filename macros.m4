# We have /bin/sh code with quotes
changequote(`[[',`]]')

define([[COMPILE_WHIZARD]],
  [[ mkdir _build && \
     cd _build && \
     ../configure --disable-static FCFLAGS="-O2 -g" && \
     make -j `getconf _NPROCESSORS_ONLN` && \
     make -j `getconf _NPROCESSORS_ONLN` check && \
     make install && \
     ldconfig && \
     whizard && \
     make -j `getconf _NPROCESSORS_ONLN` installcheck && \
     cd .. && \
     rm -fr _build ]])

define([[BUILD_WHIZARD_RELEASE]],
  [[ FROM thomega/whizard_tools:latest
     MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
     LABEL \
       org.hepforge.whizard.image="installation" \
       org.hepforge.whizard.version="$1" \
       org.hepforge.whizard.status="release"
     WORKDIR /tmp
     RUN \
       wget http://www.hepforge.org/archive/whizard/whizard-$1.tar.gz && \
       tar xzf whizard-$1.tar.gz && \
       cd whizard-$1 && \
       COMPILE_WHIZARD && \
       cd .. && \
       rm -fr whizard-$1
     USER whizard
     WORKDIR /home/whizard ]])

define([[BUILD_HEPMC]],
  [[ RUN \
       wgetx http://lcgapp.cern.ch/project/simu/HepMC/download/HepMC-$1.tar.gz && \
       tar xzf HepMC-$1.tar.gz && \
       rm -f HepMC-$1.tar.gz && \
       cd HepMC-$1 && \
       ./configure --with-momentum=GEV --with-length=MM && \
       make -j `getconf _NPROCESSORS_ONLN` && \
       make check && \
       make install && \
       ldconfig && \
       cd .. && \
       rm -fr HepMC-$1 ]])

define([[BUILD_LHAPDF]],
  [[ RUN \
       wgetx http://www.hepforge.org/archive/lhapdf/LHAPDF-$1.tar.gz && \
       tar xzf LHAPDF-$1.tar.gz && \
       rm -f LHAPDF-$1.tar.gz && \
       cd LHAPDF-$1 && \
       ./configure && \
       make -j `getconf _NPROCESSORS_ONLN` && \
       make install && \
       ldconfig && \
       lhapdf install cteq6l1 CT10 && \
       cd .. && \
       rm -fr LHAPDF-$1 ]] )


