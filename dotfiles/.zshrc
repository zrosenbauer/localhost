####
# Oh-my-zsh
####

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="zrosenbauer"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

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
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()

source $ZSH/oh-my-zsh.sh

####################
# Custom Configurations
####################


###
# Primary Configurations
###

export MANPATH="/usr/local/man:$MANPATH"
export PATH="/usr/local/bin:$PATH" 
export PATH="/opt/homebrew/bin:$PATH"
export PATH_VSCODE="$HOME/Library/Application Support/Code"
export PATH_VSCODE_ICONS="$PATH_VSCODE/User/vscode-custom-icons"

# You may need to manually set your language environment
export LANG=en_US.UTF-8x

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

###
# Aliases
###
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias cloud_sql_proxy="~/cloud_sql_proxy"
alias ls="eza"
alias hal="yarn hal"
alias plm="yarn pulumi"
alias code="open -b com.microsoft.VSCode"

# Canvas PKG
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig

###
# Custom Scripts & Tools
###

## Import custom scripts & tools
source ~/zac-shell/unicorn-git.sh

# nvm setup
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/zrosenbauer/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/zrosenbauer/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/zrosenbauer/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/zrosenbauer/google-cloud-sdk/completion.zsh.inc'; fi

###
# Special ENV Variables 
###

NOW="$(date '+%F_%H:%M:%S')"
TODAY="$(date '+%F')"

# bun completions
[ -s "/Users/zrosenbauer/.bun/_bun" ] && source "/Users/zrosenbauer/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh # Or run `brew info chruby` to find out installed directory
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

# depot
export DEPOT_TOKEN="depot_a7f49e561a0e567931dd273382fa801f87716586411eceed3c4b3d3173513996"
export DEPOT_ORG_ID="5tfztl8kcs"

# turborepo
export TURBO_TOKEN=$DEPOT_TOKEN
export TURBO_TEAM=$DEPOT_ORG_ID
export TURBO_API="https://cache.depot.dev"
