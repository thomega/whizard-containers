FROM thomega/whizard_build_env
MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
USER root
RUN apt-get install -y python libboost-dev
USER whizard
WORKDIR /home/whizard
RUN mkdir src
WORKDIR src
RUN wgetx http://lcgapp.cern.ch/project/simu/HepMC/download/HepMC-2.06.09.tar.gz
RUN tar xzf HepMC-2.06.09.tar.gz
WORKDIR HepMC-2.06.09
RUN ./configure --with-momentum=GEV --with-length=MM
RUN make -j `getconf _NPROCESSORS_ONLN`
RUN make check
USER root
RUN make install
USER whizard
WORKDIR /home/whizard/src
RUN wgetx http://www.hepforge.org/archive/lhapdf/LHAPDF-6.1.5.tar.gz
RUN tar xzf LHAPDF-6.1.5.tar.gz
WORKDIR LHAPDF-6.1.5
RUN ./configure
RUN make -j `getconf _NPROCESSORS_ONLN`
USER root
RUN make install
RUN lhapdf-getdata --dest=`lhapdf-config --pdfsets-path` \
      cteq61.LHpdf cteq6ll.LHpdf cteq5l.LHgrid GSG961.LHgrid
USER whizard
WORKDIR /home/whizard
