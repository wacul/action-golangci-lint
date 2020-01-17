#!/bin/bash

set -e

cd "$GITHUB_WORKSPACE"

golangci-lint run --out-format line-number "${INPUT_GOLANGCI_LINT_FLAGS}"
