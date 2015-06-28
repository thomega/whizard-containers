FROM debian
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
RUN apt-get update
RUN apt-get install -y gfortran g++ make ocaml-nox wget
ADD wgetx /usr/local/bin/
RUN chmod 755 /usr/local/bin/wgetx
RUN adduser --disabled-password --gecos 'WHIZARD User' whizard
USER whizard