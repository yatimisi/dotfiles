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

		echo "Done. $HOME/.antigen"
		echo ""
	fi;

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
