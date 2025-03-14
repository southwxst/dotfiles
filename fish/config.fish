function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

function te
    trans :en $argv
end

function tj
    trans :ja $argv
end
alias pamcan=pacman
# エイリアス設定（alias推奨）
alias y=yazi
alias f=fastfetch
alias tf=thefuck
alias v=nvim
alias p=python
alias tf='trans :fr'
alias wk='tomatoshell'
alias cl='xclip -selection clipboard'
set -gx PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.emacs.d/bin $PATH
function __fzf_find_file
    fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' --height=40% --border
end

bind \ct '__fzf_find_file | read -l file; and commandline -f repaint; and commandline -i $file'
#fish_vi_key_bindings
# zoxide を有効化
zoxide init fish | source
# function fish_prompt
#   set_color cyan; echo (pwd)
#   set_color green; echo '> '
# end
