#!/bin/bash

readonly CUR_DIR=`pwd`
readonly ZFILES=(".zlogin" ".zlogout" ".zpreztorc" ".zprofile" ".zshenv" ".zshrc")

if [ ! -d "${HOME}"/.config ]; then
  mkdir "${HOME}"/.config
fi

for zfile in ${ZFILES[@]}; do
  ln -s "${CUR_DIR}/${zfile}" "${HOME}"/
  ln -s "${CUR_DIR}/${zfile}" "${HOME}"/.zprezto/runcoms/
done
