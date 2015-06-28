FROM debian:latest
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
########################################################################

RUN apt-get update
RUN apt-get install --no-install-recommends -yq \
   gfortran g++ make ocaml-nox wget ca-certificates noweb \
   texlive-latex-base ocamlweb \
   less && apt-get clean

ADD wgetx /usr/local/bin/
RUN chmod 755 /usr/local/bin/wgetx

RUN adduser --disabled-password --gecos 'WHIZARD User' whizard
USER whizard
WORKDIR /home/whizard
