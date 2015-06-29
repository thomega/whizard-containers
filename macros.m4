# We have /bin/sh code with quotes
changequote(`[[',`]]')

define([[COMPILE_WHIZARD]],
  [[ mkdir _build && \
     cd _build && \
     ../configure --disable-static FCFLAGS="-O2 -g" && \
     make -j `getconf _NPROCESSORS_ONLN` && \
     make -j `getconf _NPROCESSORS_ONLN` check && \
     make install && \
     ldconfig && \
     whizard && \
     make -j `getconf _NPROCESSORS_ONLN` installcheck ]])

define([[BUILD_WHIZARD_RELEASE]],
  [[ FROM thomega/whizard_tools:latest
     MAINTAINER "Thorsten Ohl <ohl@physik.uni-wuerzburg.de>"
     LABEL \
       org.hepforge.whizard.image="installation" \
       org.hepforge.whizard.version="$1" \
       org.hepforge.whizard.status="release"
     WORKDIR /tmp
     RUN \
       wget http://www.hepforge.org/archive/whizard/whizard-$1.tar.gz && \
       tar xzf whizard-$1.tar.gz && \
       cd whizard-$1 && \
       COMPILE_WHIZARD && \
       cd /tmp && \
       rm -fr whizard-$1
     USER whizard
     WORKDIR /home/whizard ]])
