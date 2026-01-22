# docker-pandoc

[Debian](https://hub.docker.com/_/debian) based image for building documents
using [Pandoc](https://pandoc.org). This includes [GNU
make](https://www.gnu.org/software/make/).

The latest Docker image can be found on [Docker Hub](https://cloud.docker.com),
[frankhjung/pandoc](https://cloud.docker.com/repository/docker/frankhjung/pandoc/general).

## Pandoc Versions

To check the available Pandoc versions, check the package list for Debian the
release. For example, Trixie (13.3): uses the
[Pandoc 3.1.11-1
package](https://packages.debian.org/search?suite=trixie&searchon=names&keywords=pandoc).

## Login

```bash
echo [token] | docker login -u frankhjung --password-stdin
```

## Build

```bash
docker build --compress --rm --tag frankhjung/pandoc:latest .
```

## Run

```bash
docker run frankhjung/pandoc:latest
```

## Tag

Get version from run to set tag:

```bash
export VERSION=2.17.1.1
```

```bash
docker tag frankhjung/pandoc:latest frankhjung/pandoc:${VERSION}
```

Verify with:

```bash
docker image inspect --format='{{json .Config.Labels}}' frankhjung/pandoc:latest
{"2.17.1.1":"","maintainer":"frankhjung"}
```

### Example

```text
$ docker run frankhjung/pandoc:latest
pandoc 2.17.1.1
Compiled with pandoc-types 1.22.2.1, texmath 0.12.4, skylighting 0.12.3.1,
citeproc 0.6.0.1, ipynb 0.2
User data directory: /root/.local/share/pandoc
Copyright (C) 2006-2022 John MacFarlane. Web:  https://pandoc.org
This is free software; see the source for copying conditions. There is no
warranty, not even for merchantability or fitness for a particular purpose.

```

## Push

Push image and all tags to Docker Hub:

```bash
docker push -a frankhjung/pandoc
```

## Pipeline

The pipeline requires the following secret environment values:

- `DOCKERHUB_TOKEN`
- `DOCKERHUB_USERNAME`

## Links

- [Docker: Debian](https://hub.docker.com/_/debian)
- [Pandoc](https://pandoc.org/)
