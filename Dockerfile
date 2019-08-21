FROM debian:stable-slim
LABEL maintainer=frankhjung
RUN export TERM=xterm \
 && apt-get --assume-yes --list-cleanup update \
 && apt-get --yes install pandoc make
WORKDIR /opt/workspace
CMD /usr/bin/pandoc --version
