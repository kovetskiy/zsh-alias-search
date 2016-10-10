zle -N alias-search

alias-search() {
    local alias=$(alias \
        | sed -rn 'H; $ { x; s/\n\s+/ /g; p; }' \
        | sed -r \
            -e "s/^'([^']+)'=(.*)$/\1=\2/" \
            -e "s/^([^=]+)='(.*)'$/\1=\2/" \
            -e "s/^([^=]+)=([^|].*)$/\1=  \2/" \
            -e "s/^([^=]+)=(.*)$/\1\t\2/" \
        | column -ts $'\t' \
        | fzf-tmux \
        | awk '{ print $1 }'
    )

    RBUFFER="$alias$RBUFFER"
    CURSOR+=$#alias
}
