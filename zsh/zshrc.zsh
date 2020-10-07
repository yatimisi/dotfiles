## Load antigen
source "$HOME/.antigen/bin/antigen.zsh"

## Load the oh-my-zsh's library.
antigen use oh-my-zsh

# For OSX
if [[ $(uname) == "Darwin" ]]; then
  for brew in {aria2,fd,autojump,ncdu,the_silver_searcher,exa,bat,jq,htop,fzf}; do
    [[ ! -d "$(brew --prefix)/Cellar/$brew" ]] && brew install $brew
  done
  antigen bundle autojump
  [[ ! -r "$HOME/.fzf.zsh" ]] && $(brew --prefix)/opt/fzf/install --all --no-bash
fi

## Load plugins
antigen bundle git
antigen bundle pip
antigen bundle golang
antigen bundle tmux
antigen bundle docker
antigen bundle docker-compose
antigen bundle web-search
antigen bundle lukechilds/zsh-nvm
antigen bundle qoomon/zsh-lazyload
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle zpm-zsh/clipboard

## Load theme config
source "$HOME/.dotfiles/zsh/theme.zsh"

## Set theme
antigen theme denysdovhan/spaceship-prompt

## Apply settings
antigen apply

## Load custom settings
for zsh in ~/.dotfiles/zsh/{alias,config}.zsh; do
    [ -r "$zsh" ] && source "$zsh"
done
unset zsh


for f in $HOME/.dotfiles/zsh/environmentals/*.zsh; do source $f; done

load_node() {
  source "$HOME/.dotfiles/zsh/environmentals/lazyload/node.zsh"
}

load_python() {
  source "$HOME/.dotfiles/zsh/environmentals/lazyload/python.zsh"
}

lazyload nvm node npm npx git-cz ng -- 'load_node'
lazyload pyenv python pip pipenv ipython bpython -- 'load_python'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
