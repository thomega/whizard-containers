# We have /bin/sh code with quotes
changequote(`[[',`]]')

define([[DEBIAN_UPDATE]],[[RUN apt-get update]])

define([[DEBIAN_INSTALL]],
  [[dnl
# It is important to run `apt-get install' and `apt-get clean'
# in the same `RUN' statement to avoid potentially big intermediate
# levels with a lot of cruft in `/var/cache/apt/archives'
RUN apt-get install --no-install-recommends -qy \
  $1 && apt-get clean ]])

define([[COMPILE_WHIZARD]],
  [[ mkdir _build && \
     cd _build && \
     ../configure --disable-static FCFLAGS="-O2 -g" && \
     cp config.log config.status /home/whizard/ && \
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

define([[BUILD_LCIO]],
  [[dnl
# Run everything in the same `RUN' statement to avoid potentially
# big intermediate levels with a lot of deleted files
RUN \
 svn co svn://svn.freehep.org/lcio/tags/$1 lcio && \
 cd lcio && \
 mkdir _build && \
 cd _build && \
 cmake .. && \
 make install && \
 ldconfig && \
 make tests && \
 make test && \
 cd ../.. && \
 rm -fr lcio ]])

# Subversion checkout of LCIO can take ages so we
# allow ourselves to waste a little space
define([[BUILD_LCIO_LOCAL]],
  [[dnl
ADD lcio-$1.tar.gz ./
RUN \
 cd lcio && \
 mkdir _build && \
 cd _build && \
 cmake .. && \
 make install && \
 ldconfig && \
 make tests && \
 make test && \
 cd ../.. && \
 rm -fr lcio ]])

define([[BUILD_FASTJET]],
  [[dnl
# Run everything in the same `RUN' statement to avoid potentially
# big intermediate levels with a lot of deleted files
RUN \
 wgetx http://fastjet.fr/repo/fastjet-$1.tar.gz && \
 tar xzf fastjet-$1.tar.gz && \
 rm -f fastjet-$1.tar.gz && \
 cd fastjet-$1 && \
 ./configure && \
 make -j `getconf _NPROCESSORS_ONLN` && \
 make -j `getconf _NPROCESSORS_ONLN` check && \
 make install && \
 ldconfig && \
 cd .. && \
 rm -fr fastjet-$1 ]])

define([[BUILD_FASTJET_CONTRIB]],
  [[dnl
# Run everything in the same `RUN' statement to avoid potentially
# big intermediate levels with a lot of deleted files
RUN \
 wgetx http://fastjet.hepforge.org/contrib/downloads/fjcontrib-$1.tar.gz && \
 tar xzf fjcontrib-$1.tar.gz && \
 rm -f fjcontrib-$1.tar.gz && \
 cd fjcontrib-$1 && \
 ./configure && \
 make -j `getconf _NPROCESSORS_ONLN` && \
 make -j `getconf _NPROCESSORS_ONLN` check && \
 make install && \
 ldconfig && \
 cd .. && \
 rm -fr fjcontrib-$1 ]])

# stdhep doesn't build out of the box, because the
# Makefile lives in the age of g77 :( ...
define([[BUILD_STDHEP]],
  [[dnl
# Run everything in the same `RUN' statement to avoid potentially
# big intermediate levels with a lot of deleted files
RUN \
 wgetx http://cepa.fnal.gov/psm/stdhep/dist/stdhep-$1.tar.gz && \
 tar xzf stdhep-$1.tar.gz && \
 rm -f stdhep-$1.tar.gz && \
 cd stdhep-$1 && \
 make BUILD_SHARED="true" all && \
 cd .. && \
 : rm -fr stdhep-$1 ]])

define([[BUILD_GENERIC]],
  [[ RUN \
       wgetx $1/$2-$3.$4 && \
       tar xzf $2-$3.$4 && \
       rm -f $2-$3.$4 && \
       cd $2-$3 && \
       ./configure && \
       make -j `getconf _NPROCESSORS_ONLN` && \
       make install && \
       ldconfig && \
       cd .. && \
       rm -fr $2-$3 ]] )

define([[BUILD_GENERIC_STEPS]],
  [[ RUN wgetx $1/$2-$3.$4
     RUN tar xzf $2-$3.$4
     RUN rm -f $2-$3.$4
     WORKDIR $2-$3
     RUN ./configure
     RUN make -j `getconf _NPROCESSORS_ONLN`
     RUN make install
     RUN ldconfig
     WORKDIR ..
     RUN rm -fr $2-$3 ]] )

define([[BUILD_HOPPET]],
  [[ BUILD_GENERIC([[https://hoppet.hepforge.org/downloads]],
                   [[hoppet]], [[$1]], [[tgz]]) ]])

