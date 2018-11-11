if [[ -z $_zsh_done_env ]]; then
	_zsh_done_env=1
	# Ensure that a non-login, non-interactive shell has a defined environment.
	if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
	  source "${ZDOTDIR:-$HOME}/.zprofile"
	fi

	# Thing to add to PATH, if they exist
	DIRS=(
		/usr/local/bin
		/usr/X11R6/bin
		~/bin
		~/Library/Python/2.7/bin
		~/Library/Python/3.7/bin
		~/Library/Python/3.6/bin
		~/.local/bin
		~/.cargo/bin
		~/go/bin
		~/.pyenv/bin
		)

	export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin
	for d in $DIRS; do
		if [ -d $d ]; then
			export PATH=$PATH:$d
		fi
	done

	[[ -d $HOME/src/botocoreAmazon ]] && export PYTHONPATH=$PYTHONPATH:$HOME/src/botocoreAmazon

	if [[ -x "/usr/local/bin/pyenv" ]]; then
		_zsh_load_info="$_zsh_load_info\ninitialised pyenv"
		eval "$(pyenv init -)"
		eval "$(pyenv virtualenv-init -)"
	fi

	path_bits=(${(s.:.)PATH})
	unique_path_bits=(${(u)path_bits[@]})
	unique_path=${(j.:.)unique_path_bits}
	export PATH=$unique_path
fi
