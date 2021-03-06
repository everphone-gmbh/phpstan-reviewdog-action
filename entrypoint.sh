#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

vendor/bin/phpstan --error-format=raw analyse -l max src \
  | reviewdog -f="phpstan" -tee -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}"
