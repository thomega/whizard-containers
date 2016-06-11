FROM thomega/whizard_tools:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
LABEL \
  org.hepforge.whizard.image="installation" \
  org.hepforge.whizard.status="unreleased subversion trunk"
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
  COMPILE_WHIZARD([[--enable-hoppet --enable-fastjet --enable-openloops]])&& \
  chown -R whizard.whizard /home/whizard

########################################################################
USER whizard
WORKDIR /home/whizard
