# Repo: https://github.com/yatimisi/dotfiles
set -e

cd "$(dirname "${BASH_SOURCE}")";

function main() {

	# Clone ---------------------------------------------------------------------
	if [ ! -d "$HOME/.antigen" ]; then
		echo "Clone: https://github.com/zsh-users/antigen > $HOME/.antigen";

		command -v git > /dev/null \
		&& { git clone https://github.com/zsh-users/antigen.git $HOME/.antigen;} \
		|| ( mkdir "$HOME/.antigen" ; curl -#L https://github.com/zsh-users/antigen/tarball/develop | tar -xz --strip-components 1 -C $HOME/.antigen;)

		echo "Done. $HOME/.antigen";
		echo;
	fi;

	if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
		echo "Clone: https://github.com/tmux-plugins/tpm > $HOME/.tmux/plugins/tpm";

		command -v git > /dev/null \
		&& { git clone https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm;} \
		|| ( mkdir "$HOME/.tmux/plugins/tpm" ; curl -#L https://github.com/tmux-plugins/tpm/tarball/master | tar -xz --strip-components 1 -C $HOME/.tmux/plugins/tpm;)

		echo "Done. $HOME/.tmux/plugins/tpm";
		echo;
	fi;

    # Make directory ----------------------------------------------------------------
    for dir in ~/.{pip,environment}; do
        [ ! -d "$dir" ] && mkdir "$dir" && echo "Done. $dir"
    done

    # Made environment --------------------------------------------------------------
    ENV_PATH="$HOME/.environment"
    ENV=(
        'config/gitconfig/gitconfig.user'
        'config/pypirc'
    )

    for ((i=0; i < ${#ENV[@]}; i++))
    do
        if [ ! -f "$ENV_PATH/.$(basename "${ENV[$i]}")" ]; then
            cp ${ENV[$i]} "$ENV_PATH/.$(basename "${ENV[$i]}")" && echo "Done. $ENV_PATH/.$(basename "${ENV[$i]}")"
        fi
    done

	echo "Enjoy this."
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	main -f;
else
	echo "This may overwrite existing files in your home directory.";
	echo;
	echo "example:";
	echo "    ~/.antigen";
	echo "    ~/.tmux";
	echo "    ~/.environment";
	echo "    ~/.dotfiles";
	echo "    ~/.zshrc";
	echo "    ~/.gitconfig";
	echo "    ~/.pypirc";
	echo "    ~/.pip";
	echo "    ~/.tmux.conf";
	echo "    ~/.vimrc";
	echo "    ~/.vim";
	echo "    ~/.czrc";
	echo;
	read -p "Are you sure? (y/N) " -n 0 && [[ $REPLY == "" ]] && echo "N";

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		main;
	fi;
fi;
unset main;
