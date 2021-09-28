#!/usr/bin/env bash

# https://stackoverflow.com/questions/57927115/anyone-know-a-way-to-delete-a-workflow-from-github-actions#:~:text=As%20of%20July%207%2C%202020,its%20logs%20will%20be%20removed.
# https://docs.github.com/en/rest/reference/actions#list-workflow-runs-for-a-repository
# https://qmacro.org/autodidactics/2021/03/26/mass-deletion-of-github-actions-workflow-runs/

# NOTE: Only functions prefixed with `gh.` are public functions
# Rest of the functions are internal / private

#set -o errexit
#set -o pipefail

function jqscript () {
    cat <<EOF
      def symbol:
        sub("skipped"; "SKIP") |
        sub("success"; "GOOD") |
        sub("failure"; "FAIL");

      def tz:
        gsub("[TZ]"; " ");

      .workflow_runs[]
        | [
            .id,
            (.conclusion | symbol),
            (.created_at | tz),
            .event,
            .name
          ]
        | @tsv
EOF
}

function parse_wf_run_id () {
  # NOTE: The column where id is expected to be depends on
  # on the order decided in the function `jqscript`. Currently,
  # id is the first column
  echo "$(cut -f 1 <<< "$1")"
}

function gh.wfs.delete.run () {
  local repo id url result

  repo=${1:?No owner/repo specified}
  id=${2:?Workflow run id not specified}
  url="/repos/${repo}/actions/runs/${id}"

  echo q | gh api -X DELETE "${url}"
  [[ $? = 0 ]] && result="OK!" || result="BAD"
  echo >&2  "Workflow run id: ${id} --> ${result}"
}

function gh.wfs.list.run_ids () {
  gh.list_wf_runs vivekragunathan/gh-actions-test | while read line; do
    cut -f1 <<< "${line}"
  done
}

function delete_wf_runs () {
    local repo id

    repo=${1:?No owner/repo specified}

    while read -r run; do
      id="$(parse_wf_run_id "${run}")"
      gh.wfs.delete.run "${repo}" "${id}"
      #sleep 0.25
    done
}

function gh.wfs.list () {
  local repo

  repo=${1:?No owner/repo specified}

  # gh api --paginate "/repos/$repo/actions/runs" | jq -r -f <(jqscript) # | fzf --multi
  gh api --paginate "/repos/$repo/actions/runs"  | jq -r '.workflow_runs[] | [.id,.conclusion,.created_at,.event,.name] | @tsv'
}

function gh.wfs.delete () {
  local repo

  repo=${1:?No owner/repo specified}

  gh.list_wf_runs "${repo}" | delete_wf_runs "${repo}"
}
