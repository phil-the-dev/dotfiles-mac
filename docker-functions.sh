
dc:reboot() { dc down && dc up -d $@ }
dc:rebuild() { dc:reboot --build }

dc:bash() { dc exec $1 bash $@}
railsc() { dc:bash $1 "rails c" }
logs() { dc logs -f --tail=10 $1 }
logs:all() { dc logs -f $1 }

# Example of how to dynamically create dc functions for containers
# container_functions(){
#   containers=('web');
#   for container in $containers;
#   do
#     eval "function "$container":railsc() { railsc "$container" }"
#     eval "function "$container":logs() { logs "$container" }"
#     eval "function "$container":logs:all() { logs:all "$container" }"
#     eval "function "$container":bash() { dc:bash "$container" }"
#   done
# }

# container_functions