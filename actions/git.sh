#!/usr/bin/env bash

source "actions/utils.sh"

gh_sha="${1:?git sha not specified}"

banner 'Authenticating @ GitHub'
echo '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' | gh auth login --with-token

banner "Fetching git diff (${gh_sha})"
git diff-tree --no-commit-id --patch-with-raw -r "${gh_sha}"

# echo '>>> List workflows'
# gh workflow view CI
