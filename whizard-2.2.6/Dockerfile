FROM thomega/whizard_tools:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
########################################################################

ENV WHIZARD whizard-2.2.6

########################################################################
# These should have already been set by whizard_build_env 
USER whizard
WORKDIR /home/whizard

########################################################################
RUN mkdir -p src
WORKDIR src

########################################################################
# WHIZARD
########################################################################

RUN wget http://www.hepforge.org/archive/whizard/$WHIZARD.tar.gz
RUN tar xzf $WHIZARD.tar.gz
WORKDIR $WHIZARD
RUN mkdir _build
WORKDIR _build
RUN ../configure --disable-static FCFLAGS="-O2 -g"
RUN make -j `getconf _NPROCESSORS_ONLN`
RUN make -j `getconf _NPROCESSORS_ONLN` check
USER root
RUN make install
RUN ldconfig
USER whizard
RUN make -j `getconf _NPROCESSORS_ONLN` installcheck
WORKDIR ..
RUN rm -fr _build

########################################################################
WORKDIR /home/whizard
