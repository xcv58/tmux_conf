#!/bin/bash
export PATH=$PATH:/usr/local/bin

# abort if we're already inside a TMUX session
[ "$TMUX" == "" ] || exit 0

create() {
  tmux new-session -s "$1" -d

  create_2x2_current_window

  tmux new-window -t "$1:2"
  create_2x2_current_window

  tmux select-window -t "$1:1"
  tmux select-pane -t top-left
}

create_2x2_current_window() {
  tmux split-window -h
  tmux select-pane -L
  tmux split-window -v
  tmux select-pane -R
  tmux split-window -v
  tmux select-layout tiled >/dev/null
}

connect() {
  tmux attach-session -t "${@}"
  exit
}

contains() {
  for i in "${options[@]}"
  do
    if [[ ${1} == "${i}" ]]; then
      return 0
    fi
  done
  return 1
}

connect_or_default() {
  # shellcheck disable=SC2015
  contains "$1" && connect "$1" || connect "${options[0]}"
}

DEFAULT=_default
# startup a "default" session if none currently exists
tmux has-session -t "$DEFAULT" || create "$DEFAULT"

# shellcheck disable=SC2046
IFS=$'\n'
options=($(tmux list-sessions -F '#S'))
unset IFS
if [[ $# -gt 0 ]]; then
  argument="${*}"
  argument=${argument// /-}
  contains "${argument}" && connect "${argument}"
  # shellcheck disable=SC2015
  connect_or_default "${options[$argument]}"
fi

# present menu for user to choose which workspace to open
PS3="Please choose your session: "

options+=("NEW SESSION" "zsh")

echo "Available sessions"
echo "------------------"
echo " "
select opt in "${options[@]}"
do
  case ${opt} in
    "NEW SESSION")
      read -r -p "Enter new session name: " SESSION_NAME
      create "$SESSION_NAME"
      connect "$SESSION_NAME"
      break;;
    "zsh")
      zsh --login
      break;;
    *)
      connect_or_default "${opt}"
      break;;
  esac
done
