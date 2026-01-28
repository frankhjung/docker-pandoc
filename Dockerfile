ARG PANDOC_VERSION=3.1.11.1
FROM debian:stable-slim
# Re-declare ARG after FROM to make it available in the build stage
ARG PANDOC_VERSION
LABEL maintainer=frankhjung@linux.com
LABEL version="${PANDOC_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/frankhjung/docker-pandoc"
RUN export TERM=xterm \
 && apt-get --assume-yes --list-cleanup update \
 && apt-get --yes --no-install-recommends install make pandoc \
 && apt-get --yes --no-install-recommends install texlive-latex-base texlive-latex-recommended texlive-xetex lmodern texlive-fonts-recommended
WORKDIR /opt/workspace
CMD ["/usr/bin/pandoc", "--version"]
