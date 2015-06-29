FROM thomega/whizard_tools:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
########################################################################

RUN apt-get install --no-install-recommends -yq \
     subversion automake libtool && apt-get clean

########################################################################
WORKDIR /home/whizard
RUN mkdir -p src
WORKDIR src

########################################################################
# WHIZARD
########################################################################

RUN \
  svn co http://whizard.hepforge.org/svn/trunk whizard && \
  cd whizard && \
  autoreconf && \
  mkdir _build && \
  cd _build && \
  ../configure --disable-static FCFLAGS="-O2 -g" && \
  make -j `getconf _NPROCESSORS_ONLN` && \
  make -j `getconf _NPROCESSORS_ONLN` check && \
  make install && \
  ldconfig && \
  make -j `getconf _NPROCESSORS_ONLN` installcheck && \
  cd .. && \
  rm -fr _build && \
  chown -R whizard.whizard /home/whizard

########################################################################
USER whizard
WORKDIR /home/whizard
