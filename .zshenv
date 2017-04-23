path=(
	/usr/local/bin
	${HOME}/Library/Android/sdk/platform-tools(N-/)
	${HOME}/Library/Android/sdk/ndk-bundle(N-/)
	$path
)

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"
