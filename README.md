# docker-pandoc

[Debian](https://hub.docker.com/_/debian) based image for building documents
using [Pandoc](https://pandoc.org). This includes [GNU
make](https://www.gnu.org/software/make/).

The latest Docker image can be found on [Docker Hub](https://cloud.docker.com),
[here](https://cloud.docker.com/repository/docker/frankhjung/pandoc/general).

## Run

```bash
docker run frankhjung/pandoc:latest
```

### Example

```
Unable to find image 'frankhjung/pandoc:latest' locally
latest: Pulling from frankhjung/pandoc
eafd24d25890: Already exists
8315833a2172: Pull complete
859e0547fad1: Pull complete
Digest: sha256:2afd53035ef9eda90bce49a9669898cb57bdb84e76dcaa432a14fa5115a043a9
Status: Downloaded newer image for frankhjung/pandoc:latest
pandoc 2.2.1
Compiled with pandoc-types 1.17.5.1, texmath 0.11.1, skylighting 0.7.5
Default user data directory: /root/.pandoc
Copyright (C) 2006-2018 John MacFarlane
Web:  http://pandoc.org
This is free software; see the source for copying conditions.
There is no warranty, not even for merchantability or fitness
for a particular purpose.
```
