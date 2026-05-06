#!/bin/zsh
#
set -e

SCRIPT_FILE=$0
SCRIPT_PATH=$(dirname $SCRIPT_FILE)
cd ${SCRIPT_PATH}

unamestr=`uname`
if [ "$unamestr" = 'Darwin' ]; then
    lnCommand="ln -sf"
    command -v reattach-to-user-namespace >/dev/null 2>&1 || brew install reattach-to-user-namespace
else
    lnCommand="ln -Pf"
fi

for config_file in ${PWD}/*.conf; do
    link_command="${lnCommand} ${config_file} ${HOME}/.${config_file:t}"
    echo ${link_command}
    eval ${link_command}
done

link_command="${lnCommand} ${PWD}/tmux-pst.sh ${HOME}/.tmux-pst.sh"
echo ${link_command}
eval ${link_command}

if [ -w /usr/local/bin ]; then
    link_command="ln -sf ${PWD}/zellij.start.sh /usr/local/bin/t"
else
    link_command="sudo ln -sf ${PWD}/zellij.start.sh /usr/local/bin/t"
fi
echo ${link_command}
eval ${link_command}

mkdir -p ${HOME}/.config/zellij
link_command="${lnCommand} ${PWD}/zellij/config.kdl ${HOME}/.config/zellij/config.kdl"
echo ${link_command}
eval ${link_command}

link_command="ln -sfn ${PWD}/zellij/layouts ${HOME}/.config/zellij/layouts"
echo ${link_command}
eval ${link_command}
