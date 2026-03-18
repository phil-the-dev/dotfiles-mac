#!/bin/bash

clone_or_pull() {
    local repo_path="${1}"
    local target_dir="${2}"
    local project="$(echo "${repo_path}" | cut -d"/" -f2)"

    # Default to current directory if no target specified
    local project_path="${target_dir:-$project}"

    if [ -d "${project_path}" ]; then
        info "Updating ${repo_path}..."
        git -C "${project_path}" pull
        echo
    else
        info "Installing ${repo_path}..."
        git clone "https://github.com/${repo_path}" "${project_path}"
        echo
    fi
}
