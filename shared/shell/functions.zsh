# Reload shell config
re:source() { source ~/.zshrc }

# Docker-compose helpers (generic)
dc:reboot()  { dc down && dc up -d $@ }
dc:rebuild() { dc:reboot --build }
dc:bash()    { local all_args=("$@"); local rest=("${all_args[@]:1}"); dc exec $1 bash $rest[@]; }
railsc()     { dc:bash $1 -c "rails c" }
bundle:i()   { dc:bash $1 -c "bundle install" }
logs()       { dc logs -f --tail=10 $1 }
logs:all()   { dc logs -f $1 }
