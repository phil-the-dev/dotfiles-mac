#!/bin/sh

clone_or_pull() {
    local repo_path="${1}"
    local project="$(echo "${repo_path}" | cut -d"/" -f2)"
    local project_path="${project}"

    if cd "${project_path}" > /dev/null 2>&1; then
        info "Updating ${repo_path}..."
        git pull
        echo
        cd - > /dev/null 2>&1
    else
        info "Installing ${repo_path}..."
        git clone "https://github.com/${repo_path}" 
        echo
    fi
}