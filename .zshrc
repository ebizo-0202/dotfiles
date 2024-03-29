# -------------------------------------
# 環境変数
# -------------------------------------
export PATH=/usr/local/bin:$PATH
export RBENV_ROOT=/usr/local/var/rbenv
# export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"
# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# GOPATH
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# GAE fo GO
export PATH=$HOME/go_appengine:$PATH

# pyenv
PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PKG_CONFIG_PATH=/usr/local/opt/imagemagick@6/lib/pkgconfig
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# エディタ
export EDITOR=/usr/local/bin/vim

# ページャ
# export PAGER=/usr/local/bin/vimpager
# export MANPAGER=/usr/local/bin/vimpager
# alias less=$PAGER
# alias zless=$PAGER


# -------------------------------------
# zshのオプション
# -------------------------------------

## 補完機能の強化
autoload -U compinit
compinit

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
## タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

# -------------------------------------
# パス
# -------------------------------------

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

path=(
    $HOME/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $path
)

# -------------------------------------
# プロンプト
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "<S>"
    zstyle ":vcs_info:git:*" unstagedstr "<U>"
    zstyle ":vcs_info:git:*" formats "(%b) %c%u"
    zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# end VCS

#zshプロンプトにモード表示####################################
VIMODE='[i]'
function zle-keymap-select {
 VIMODE="${${KEYMAP/vicmd/[n]}/(main|viins)/[i]}"
 zle reset-prompt
}

zle -N zle-keymap-select

OK="^_^ "
NG="X_X "

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="%F{blue}%~%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="\${VIMODE}"
PROMPT+="
"
PROMPT+="%% "

RPROMPT="[%*]"

# -------------------------------------
# エイリアス
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# ls
alias ls="ls -G" # color for darwin
alias l="ls -la"
alias la="ls -la"
alias l1="ls -1"

# vim
alias vi="vim"

# tree
alias tree="tree -NC" # N: 文字化け対策, C:色をつける

# git
alias gs='git status'
alias gl='git log --graph'
alias gg="git grep --break --heading"
alias gche="git checkout"
alias gcom="git commit -v -n"
alias ga="git add"
alias gaa="git add ."
alias gp="git push origin HEAD"
alias gf="git fetch"
alias g='git'
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'
alias -g LR='`git branch -a | peco --query "remotes/ " --prompt "GIT REMOTE BRANCH>" | head -n 1 | sed "s/^\*\s*//" | sed "s/remotes\/[^\/]*\/\(\S*\)/\1 \0/"`'


# -------------------------------------
# キーバインド
# -------------------------------------

bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
bindkey '^K' cdup

bindkey "^R" history-incremental-search-backward

# -------------------------------------
# その他
# -------------------------------------

# cdしたあとで、自動的に ls する
function chpwd() { ls -1 }

# iTerm2のタブ名を変更する
function title {
    echo -ne "\033]0;"$*"\007"
}

alias tmux="TERM=screen-256color-bce tmux"

# history
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi
export PATH=$HOME/.pyenv/shims:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ichikawayuki/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ichikawayuki/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ichikawayuki/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ichikawayuki/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

function tmux-remake-socket () {
    if [ ! $TMUX ]; then
        return
    fi
    tmux_socket_file=`echo $TMUX|awk -F, '{print $1}'`
    if [ ! -S $tmux_socket_file ]; then
        mkdir -m700 `dirname $tmux_socket_file` 2> /dev/null
        killall -SIGUSR1 tmux
    else
        echo tmux unix domain socket exists! nothing to do.
    fi
    unset tmux_socket_file
}

export PATH=$HOME/.nodenv/bin:$PATH
eval "$(nodenv init -)"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
