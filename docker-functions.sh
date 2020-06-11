
dc:reboot() { dc down && dc up -d $@ }
dc:rebuild() { dc:reboot --build }

dc:bash() { all_args=("$@"); rest_args=("${all_args[@]:1}"); dc exec $1 bash $rest_args[@];}
railsc() { dc:bash $1 -c "rails c" }
bundle:i() { dc:bash $1 -c "bundle install"}
logs() { dc logs -f --tail=10 $1 }
logs:all() { dc logs -f $1 }

# Example of how to dynamically create dc functions for containers
# repo_dir="~/Documents/Development\ Repos/"

# declare -A rails_containers
# rails_containers=( [web]="repo1" )
# declare -A database_containers
# database_containers=( [postgres]="repo2" )
# container_functions(){
#   for container repo in ${(kv)rails_containers};
#   do
#     rails_container_actions $container
#     generic_container_actions $container $repo
#   done

#   for repo in ${(v)rails_containers};
#   do
#     generic_repo_actions $repo
#   done

#   for repo in ${(v)database_containers};
#   do
#     generic_repo_actions $repo
#   done
# }

# rails_container_actions(){
#   eval "function ${1}:rspec() { rspec ${1} \$@ }"
#   eval "function ${1}:rspec:all() { rspec:all ${1} }"
#   eval "function ${1}:railsc() { railsc ${1} }"
#   eval "function ${1}:bundle() { bundle:i ${1} }"
#   eval "function ${1}:logs() { logs ${1} }"
#   eval "function ${1}:logs:all() { logs:all ${1} }"
#   eval "function ${1}:bash() { dc:bash ${1} \$@ }"
# }

# generic_container_actions(){
#   eval "function dc:${1}:up() { dc -f ${repo_dir}${2}/docker-compose.yml up -d ${1} }"
#   eval "function d:${1}:attach() { echo 'press Ctrl+q+p to exit' && docker attach ${2}_${1}_1 }"
# }

# generic_repo_actions(){
#   eval "function dc:${1}:up() { dc -f ${repo_dir}${1}/docker-compose.yml up -d \$@ }"
#   eval "function dc:${1}:down() { dc -f ${repo_dir}${1}/docker-compose.yml down \$@ }"
#   eval "function dc:${1}:reboot() { dc:${1}:down && dc:${1}:up \$@ }"
#   eval "function dc:${1}:rebuild() { dc:${1}:reboot --build \$@ }"
# }

# container_functions