# Repo: https://github.com/yatimisi/dotfiles
set -e

cd "$(dirname "${BASH_SOURCE}")";

function main() {

	echo "Enjoy this."
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	main -f;
else
	echo "This may overwrite existing files in your home directory.";
	echo;
	echo "example:";
	echo "    ~/.environment";
	echo "    ~/.dotfiles";
	echo "    ~/.zshrc";
	echo "    ~/.gitconfig";
	echo "    ~/.pypirc";
	echo "    ~/.pip/pip.conf";
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
