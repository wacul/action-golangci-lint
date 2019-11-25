# GitHub Action: Run golangci-lint

[![Docker Image CI](https://github.com/kyoh86/action-golangci-lint/workflows/Docker%20Image%20CI/badge.svg)](https://github.com/kyoh86/action-golangci-lint/actions)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/kyoh86/action-golangci-lint)](https://hub.docker.com/r/kyoh86/action-golangci-lint)
[![Docker Pulls](https://img.shields.io/docker/pulls/kyoh86/action-golangci-lint)](https://hub.docker.com/r/kyoh86/action-golangci-lint)
[![Release](https://img.shields.io/github/release/kyoh86/action-golangci-lint.svg?maxAge=43200)](https://github.com/kyoh86/action-golangci-lint/releases)

This action runs [golangci-lint](https://github.com/golangci/golangci-lint)

## Inputs

### `golangci_lint_flags`

Optional. golangci-lint flags. (golangci-lint run --out-format=line-number
`<golangci_lint_flags>`)

Note that you can change golangci-lint behavior by [configuration
file](https://github.com/golangci/golangci-lint#configuration) too.

## Example usage

### Minimum Usage Example

#### [.github/workflows/linter.yml](.github/workflows/linter.yml)

```yml
name: linter
on: [push]
jobs:
  golangci-lint:
    name: runner / golangci-lint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: golangci-lint
        uses: kyoh86/action-golangci-lint@v1
        # uses: docker://kyoh86/action-golangci-lint:v1 # pre-build docker image
```

### Advanced Usage Example

#### [.github/workflows/linter.yml](.github/workflows/linter.yml)

```yml
name: golanci-lint
on: [push]
jobs:
  # NOTE: golangci-lint doesn't report multiple errors on the same line from
  # different linters and just report one of the errors?

  golangci-lint-prebuilt:
    name: runner / golangci-lint (pre-build docker image)
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: golangci-lint
        uses: docker://kyoh86/action-golangci-lint:v1 # Pre-built image
        with:
          golangci_lint_flags: "--config=.github/.golangci.yml ./testdata"

  golangci-lint-dockerfile:
    name: runner / golangci-lint (Dockerfile)
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: golangci-lint w/ Dockerfile
        uses: kyoh86/action-golangci-lint@v1 # Build with Dockerfile
        with:
          golangci_lint_flags: "./testdata"

  golint:
    name: runner / golint
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: golint
        uses: docker://kyoh86/action-golangci-lint:v1
        with:
          golangci_lint_flags: "--disable-all -E golint ./testdata"
```

### All-in-one golangci-lint configuration without config file

#### [.github/workflows/allinone.yml](.github/workflows/allinone.yml)

```yml
name: golanci-lint
on: [push]
jobs:
  # NOTE: golangci-lint doesn't report multiple errors on the same line from
  # different linters and just report one of the errors?

  golangci-lint-all-in-one:
    name: runner / golangci-lint-all-in-one
    runs-on: ubuntu-latest
    steps:
      - name: Check out code into the Go module directory
        uses: actions/checkout@v1
      - name: golangci-lint (All-In-One config)
        uses: docker://kyoh86/action-golangci-lint:v1
        with:
          golangci_lint_flags: "--enable-all --exclude-use-default=false ./testdata"
```
