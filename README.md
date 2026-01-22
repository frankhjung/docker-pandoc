# docker-pandoc

A [Debian](https://hub.docker.com/_/debian)-based image for building documents
using [Pandoc](https://pandoc.org). This includes [GNU
make](https://www.gnu.org/software/make/).

The latest Docker image can be found on:

- [Docker Hub](https://hub.docker.com/r/frankhjung/pandoc): `frankhjung/pandoc:latest`
- [GitHub Container Registry](https://github.com/frankhjung/docker-pandoc/pkgs/container/pandoc): `ghcr.io/frankhjung/pandoc:latest`

## Pandoc Versions

To check available Pandoc versions, refer to the package list for the Debian
release. For example, Trixie (13.3) uses the [Pandoc 3.1.11-1
package](https://packages.debian.org/search?suite=trixie&searchon=names&keywords=pandoc).

## Updating the Pandoc Version

The Pandoc version is managed via a GitHub repository variable `PANDOC_VERSION`. This should match the Debian package version available in the stable repository.

To update the version:

1. Check the available Pandoc version in the [Debian package repository](https://packages.debian.org/search?suite=stable&searchon=names&keywords=pandoc)
2. Go to the repository's Settings → Secrets and variables → Actions → Variables
3. Update the `PANDOC_VERSION` variable to match the Debian package version (e.g., `3.1.11.1`)
4. The next workflow run will automatically build and tag images with the new version

Note: The version label on the Docker image reflects the Debian package version, which is installed via `apt-get`.

## Using the Docker Image

### Docker Hub

Pull and run the latest image from Docker Hub:

```bash
docker pull frankhjung/pandoc:latest
docker run frankhjung/pandoc:latest
```

Or use a specific version:

```bash
docker pull frankhjung/pandoc:3.1.11.1
docker run frankhjung/pandoc:3.1.11.1
```

### GitHub Container Registry

Pull and run the latest image from GHCR:

```bash
docker pull ghcr.io/frankhjung/pandoc:latest
docker run ghcr.io/frankhjung/pandoc:latest
```

Or use a specific version:

```bash
docker pull ghcr.io/frankhjung/pandoc:3.1.11.1
docker run ghcr.io/frankhjung/pandoc:3.1.11.1
```

## Login

For Docker Hub:

```bash
echo [token] | docker login -u frankhjung --password-stdin
```

For GitHub Container Registry:

```bash
echo [token] | docker login ghcr.io -u frankhjung --password-stdin
```

## Build

Build the image locally:

```bash
docker build --compress --rm --tag frankhjung/pandoc:latest .
```

Build with a specific Pandoc version:

```bash
docker build --build-arg PANDOC_VERSION=3.1.11.1 --compress --rm --tag frankhjung/pandoc:3.1.11.1 .
```

## Run

```bash
docker run frankhjung/pandoc:latest
```

## Tag

### Tagging Images

The GitHub Actions workflows automatically tag images with both the version number and `latest`:

- `frankhjung/pandoc:3.1.11.1` (version-specific)
- `frankhjung/pandoc:latest` (latest build)
- `ghcr.io/frankhjung/pandoc:3.1.11.1` (version-specific)
- `ghcr.io/frankhjung/pandoc:latest` (latest build)

### Manual Tagging

Get the version from the run output to set the tag:

```bash
export VERSION=3.1.11.1
```

```bash
docker tag frankhjung/pandoc:latest frankhjung/pandoc:${VERSION}
```

Verify with:

```bash
docker image inspect --format='{{json .Config.Labels}}' frankhjung/pandoc:latest
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

The GHCR pipeline (`.github/workflows/ghcr.yml`) requires the following secret environment value:

- `GH_PAT` - GitHub Personal Access Token with `write:packages` permission

The GHCR pipeline (`.github/workflows/ghcr.yml`) requires the following
repository secret:

- `GITHUB_TOKEN` - Automatically provided by GitHub Actions with
  `write:packages` permission

## Links

- [Docker: Debian](https://hub.docker.com/_/debian)
- [Pandoc](https://pandoc.org/)
