FROM debian:testing
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
LABEL \
  org.hepforge.whizard.image="minimal build environment"
########################################################################

DEBIAN_UPDATE
DEBIAN_INSTALL([[dnl
  gfortran g++ make ocaml-nox wget ca-certificates noweb \
  texlive-latex-base texlive-latex-extra texlive-metapost \
  ghostscript feynmf ocamlweb]])

DEBIAN_INSTALL([[less vim emacs-nox]])

ADD wgetx /usr/local/bin/
RUN chmod 755 /usr/local/bin/wgetx

RUN adduser --disabled-password --gecos 'WHIZARD User' whizard
WORKDIR /home/whizard
