#!/usr/bin/env python

import sys
from utils import *

if len(sys.argv) <= 1:
    sys.exit('git.py: git sha not specified')

__GH_TOKEN__ = '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'
gh_sha = sys.argv[1]

print_cmd_output(f"echo {__GH_TOKEN__} | gh auth login --with-token", 'Authenticating @ GitHub')

print_cmd_output("gh repo view php-savers")

print_cmd_output(
    f"git diff-tree --no-commit-id --patch-with-raw -r {gh_sha}",
    f"Fetching git diff ({gh_sha})",
    also_include_stderr=True
)

# echo '>>> List workflows'
# gh workflow view CI
