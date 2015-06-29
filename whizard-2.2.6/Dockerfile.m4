FROM thomega/whizard_tools:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
LABEL \
  org.hepforge.whizard.image="installation" \
  org.hepforge.whizard.version="2.2.6" \
  org.hepforge.whizard.status="release"
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
  COMPILE_WHIZARD && \
  cd /tmp && \
  rm -fr $WHIZARD

########################################################################
USER whizard
WORKDIR /home/whizard
