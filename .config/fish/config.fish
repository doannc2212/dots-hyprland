function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

# foot
function update_cwd_osc --on-variable PWD --description 'Notify terminals when $PWD changes'
    if status --is-command-substitution || set -q INSIDE_EMACS
        return
    end
    printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
end
function mark_prompt_start --on-event fish_prompt
    echo -en "\e]133;A\e\\"
end

update_cwd_osc # Run once since we might have inherited PWD from a parent shell

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

set -g fish_key_bindings fish_hybrid_key_bindings

alias vim nvim

[ "$TERM" = xterm-kitty ] && alias ssh="kitty +kitten ssh"

starship init fish | source
if test -f ~/.config/fish/sequences.txt
    cat ~/.config/fish/sequences.txt
end

alias pamcan=pacman

# function fish_prompt
#   set_color cyan; echo (pwd)
#   set_color green; echo '> '
# end
