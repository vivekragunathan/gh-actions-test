#!/usr/bin/env bash

gh_sha="${1:?git sha not specified}"

echo '>>> Authenticating @ GitHub'
echo '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' | gh auth login --with-token

gh repo view php-savers

echo ">>> Fetching git diff (${gh_sha})"
git diff-tree --no-commit-id --patch-with-raw -r "${gh_sha}"

# echo '>>> List workflows'
# gh workflow view CI
