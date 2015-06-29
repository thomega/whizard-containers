FROM thomega/whizard_tools:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
########################################################################

ENV WHIZARD whizard-2.2.6

########################################################################
WORKDIR /tmp

########################################################################
# WHIZARD
########################################################################

RUN \
  wget http://www.hepforge.org/archive/whizard/$WHIZARD.tar.gz && \
  tar xzf $WHIZARD.tar.gz && \
  cd $WHIZARD && \
  mkdir _build && \
  cd _build && \
  ../configure --disable-static FCFLAGS="-O2 -g" && \
  make -j `getconf _NPROCESSORS_ONLN` && \
  make -j `getconf _NPROCESSORS_ONLN` check && \
  make install && \
  ldconfig && \
  whizard && \
  make -j `getconf _NPROCESSORS_ONLN` installcheck && \
  cd /tmp && \
  rm -fr $WHIZARD

########################################################################
USER whizard
WORKDIR /home/whizard
