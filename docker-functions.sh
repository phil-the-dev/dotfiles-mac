
dc:reboot() { dc down && dc up -d $@ }
dc:rebuild() { dc:reboot --build }

dc_bash() { dc exec $1 bash $@}
railsc() { dc_bash $1 "rails c" }
logs() { dc logs -f --tail=10 $1 }
logs_all() { dc logs -f $1 }

# Example of how to dynamically create dc functions for containers
# container_functions(){
#   containers=('web');
#   for container in $containers;
#   do
#     eval "function "$container":railsc() { railsc "$container" }"
#     eval "function "$container":logs() { logs "$container" }"
#     eval "function "$container":logs:all() { logs_all "$container" }"
#     eval "function "$container":bash() { dc_bash "$container" }"
#   done
# }

# container_functions