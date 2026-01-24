ARG PANDOC_VERSION=3.1.11.1
FROM debian:stable-slim
ARG PANDOC_VERSION
LABEL maintainer=frankhjung@linux.com
LABEL version="${PANDOC_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/frankhjung/docker-pandoc"
RUN export TERM=xterm \
 && apt-get --assume-yes --list-cleanup update \
 && apt-get --yes --no-install-recommends install make pandoc
WORKDIR /opt/workspace
CMD ["/usr/bin/pandoc", "--version"]
