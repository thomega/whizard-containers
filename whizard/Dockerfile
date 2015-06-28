FROM thomega/whizard_build_env
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
USER whizard
WORKDIR /home/whizard
RUN wget http://www.hepforge.org/archive/whizard/whizard-2.2.6.tar.gz
RUN tar xzf whizard-2.2.6.tar.gz
WORKDIR whizard-2.2.6
RUN mkdir _build
WORKDIR _build
RUN ../configure --disable-static FCFLAGS="-O2 -g"
RUN make -j `getconf _NPROCESSORS_ONLN`
USER root
RUN make install
USER whizard
WORKDIR /home/whizard
