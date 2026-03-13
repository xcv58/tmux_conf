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

# Check if a tmuxinator project config exists for the given name
has_tmuxinator_project() {
  local name="$1"
  for dir in "$HOME/.config/tmuxinator" "$HOME/.tmuxinator"; do
    [[ -f "$dir/$name.yml" || -f "$dir/$name.yaml" ]] && return 0
  done
  return 1
}

# Start or attach to a tmuxinator-managed session
start_tmuxinator_session() {
  local name="$1"
  if tmux has-session -t "$name" 2>/dev/null; then
    connect "$name"
  elif command -v tmuxinator &>/dev/null; then
    tmuxinator start "$name"
    exit
  fi
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
  # Check if argument matches a tmuxinator project first
  if has_tmuxinator_project "${argument}"; then
    start_tmuxinator_session "${argument}"
  fi
  contains "${argument}" && connect "${argument}"
  # shellcheck disable=SC2015
  connect_or_default "${options[$argument]}"
fi

# present menu for user to choose which workspace to open
PS3="Please choose your session: "

# Add tmuxinator projects to menu (start or attach)
if has_tmuxinator_project "LLMs"; then
  if tmux has-session -t "LLMs" 2>/dev/null; then
    # Already in the session list, no extra entry needed
    :
  else
    options+=("LLMs (create)")
  fi
fi

options+=("NEW SESSION" "zsh")

echo "Available sessions"
echo "------------------"
echo " "
select opt in "${options[@]}"
do
  case ${opt} in
    "LLMs (create)")
      start_tmuxinator_session "LLMs"
      break;;
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
