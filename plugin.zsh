zle -N alias-search

alias-search() {
    local alias=$(alias \
            | sed -r "s/^'([^']+)'='(.*)'$/\1: \2/;s/^([^=]+)=(.*)$/\1: \2/;"\
            | fzf-tmux \
            | cut -d: -f1)
    RBUFFER="$alias$RBUFFER"
    CURSOR+=$#alias
}
