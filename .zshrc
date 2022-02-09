# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add eva to path
export PATH=$HOME/.cargo/bin:$PATH

# Add diff-so-fancy to path
export PATH=$HOME/.diff-so-fancy:$PATH

# Add highlighting to less with source-highlight
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Path to your oh-my-zsh installation.
export ZSH="/home/ant/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions fasd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ant/.sdkman"
[[ -s "/home/ant/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ant/.sdkman/bin/sdkman-init.sh"

alias config='/usr/bin/git --git-dir=/home/ant/.cfg/.git --work-tree=/home/ant'
alias t='task limit:30 -WORK project.not:WORK -work'
alias ti='timew'
alias tisto='timew stop'
alias ts='timew start'
#alias tr='python3 /home/ant/r/timemerger/src/taskwarrior_project_hook/taskwarrior_task_duration_hook_on_launch.py && task limit:30 -WORK project.not:WORK -work'
alias tt='task context h && timem && vit'
alias ttr='python3 /home/ant/r/timemerger/src/hooks/total_duration_on_launch.py && task context h && vit'
alias tl='task $(task +LATEST ids)'
alias ta='task $(task +ACTIVE ids)'
alias tm='task mod'
alias tc='task context c && timem && vit'
alias i='task rc.context=none \(project.not:WORK and -WORK and -work  and \(+in or +inthe or +hass or -PROJECT\)\)'
alias ii='task context i && timem && vit'
alias ss='timem && task context s && PYTHONPATH=$PYTHONPATH:/home/ant/r/vit python /home/ant/r/vit/vit/command_line.py "sprint"'
alias in='task add +in'
alias open='xdg-open'
alias tsync='task sync && export PYTHONPATH=$PYTHONPATH:/home/ant/r/timemerger && python3 $HOME/.task/hooks/after_sync_inthe_hook.py'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=999999999
setopt INC_APPEND_HISTORY_TIME
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt correct_all # correcting mistakes
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

# source ~/r/timemerger/venv/bin/activate

# export PYTHONPATH=$PYTHONPATH:/home/ant/r/timemerger

# source /usr/share/doc/fzf/examples/key-bindings.zsh # needed on Debian
# source /usr/share/zsh/vendor-completions/_fzf # needed on Debian

# alt-c completion
# from: https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings#changing-the-layout
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Enable Vi mode
# set -o vi

# source /usr/share/doc/fzf/examples/key-bindings.zsh # needed on Debian
# source /usr/share/zsh/vendor-completions/_fzf # needed on Debian

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
bindkey -M vicmd "^V" edit-command-line
bindkey "^V" edit-command-line

export EDITOR=vim
export VISUAL=vim

# needed for zsh-completions plugin
autoload -U compinit && compinit

# zsh-autosuggestions shortcuts
bindkey '^ ' autosuggest-accept

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ant/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ant/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ant/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ant/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/tmp/fzf-git/git-fuzzy/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
