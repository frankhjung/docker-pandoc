# docker-pandoc

A [Debian](https://hub.docker.com/_/debian)-based image for building documents
using [Pandoc](https://pandoc.org). This includes [GNU
make](https://www.gnu.org/software/make/).

The latest Docker image can be found on [Docker Hub](https://cloud.docker.com),
[frankhjung/pandoc](https://cloud.docker.com/repository/docker/frankhjung/pandoc/general),
or on [GitHub Container Registry](https://ghcr.io),
[ghcr.io/frankhjung/docker-pandoc](https://github.com/frankhjung/docker-pandoc/pkgs/container/docker-pandoc).

## Pandoc Versions

To check available Pandoc versions, refer to the package list for the Debian
release. For example, Trixie (13.3) uses the [Pandoc 3.1.11-1
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

Get the version from the run output to set the tag:

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

## Using in a Pipeline

You can use this image in your CI/CD pipeline to convert documents with Pandoc.
Here are some examples:

### GitHub Actions

```yaml
name: Build Documentation
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Convert Markdown to PDF
        run: |
          docker run --rm -v $PWD:/opt/workspace \
            ghcr.io/frankhjung/docker-pandoc:latest \
            pandoc README.md -o README.pdf
      - name: Upload PDF
        uses: actions/upload-artifact@v3
        with:
          name: documentation
          path: '*.pdf'
```

### GitLab CI

```yaml
build-docs:
  image: ghcr.io/frankhjung/docker-pandoc:latest
  script:
    - pandoc README.md -o README.pdf
  artifacts:
    paths:
      - '*.pdf'
```

### Using with Make

If you have a Makefile in your project:

```yaml
build-docs:
  image: ghcr.io/frankhjung/docker-pandoc:latest
  script:
    - make docs
  artifacts:
    paths:
      - build/
```

## Pipeline Configuration

The Docker Hub pipeline (`.github/workflows/docker.yml`) requires the following
repository secrets:

- `DOCKERHUB_TOKEN`
- `DOCKERHUB_USERNAME`

The GHCR pipeline (`.github/workflows/ghcr.yml`) requires the following
repository secret:

- `GITHUB_TOKEN` - Automatically provided by GitHub Actions with
  `write:packages` permission

## Links

- [Docker: Debian](https://hub.docker.com/_/debian)
- [Pandoc](https://pandoc.org/)
