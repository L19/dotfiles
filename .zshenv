path=(
  /usr/local/sbin
  /usr/local/bin
  ${HOME}/Library/Android/sdk/platform-tools(N-/)
  ${HOME}/Library/Android/sdk/ndk-bundle(N-/)
  $path
)

if [ -d ${HOME}/.pyenv ]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
fi

if [ -d ${HOME}/.nvm ]; then
  export NVM_DIR=~/.nvm
fi

export LSCOLORS=xbfxcxdxbxegedabagacad
