#!/bin/bash
set -euo pipefail

export PATH="/opt/homebrew/bin:/usr/local/bin:${PATH}"

# Avoid nesting Zellij sessions. Use Zellij's built-in session manager from inside
# an existing session if switching is needed.
[[ -z "${ZELLIJ:-}" ]] || exit 0

if ! command -v zellij >/dev/null 2>&1; then
  echo "zellij is not installed or not available on PATH" >&2
  exit 1
fi

DEFAULT="_default"

sanitize_name() {
  local name="$*"
  name="${name// /-}"
  printf '%s' "$name"
}

list_sessions() {
  zellij list-sessions --short --no-formatting 2>/dev/null || true
}

ensure_default() {
  zellij attach --create-background "$DEFAULT" >/dev/null 2>&1 || true
}

connect() {
  local name="$1"
  zellij attach --create "$name"
  exit
}

session_by_number() {
  local number="$1"
  local index=$((number - 1))

  if (( index >= 0 && index < ${#options[@]} )); then
    printf '%s' "${options[$index]}"
    return 0
  fi

  return 1
}

ensure_default

IFS=$'\n' read -r -d '' -a options < <(list_sessions && printf '\0')

if [[ $# -gt 0 ]]; then
  argument="$(sanitize_name "$@")"

  if [[ "$argument" =~ ^[0-9]+$ ]]; then
    if selected="$(session_by_number "$argument")"; then
      connect "$selected"
    fi
    connect "$DEFAULT"
  fi

  connect "$argument"
fi

options+=("NEW SESSION" "zsh")

echo "Available Zellij sessions"
echo "-------------------------"
echo " "

PS3="Please choose your session: "
select opt in "${options[@]}"
do
  case "${opt:-}" in
    "NEW SESSION")
      read -r -p "Enter new session name: " session_name
      session_name="$(sanitize_name "$session_name")"
      [[ -n "$session_name" ]] && connect "$session_name"
      connect "$DEFAULT"
      ;;
    "zsh")
      zsh --login
      break
      ;;
    "")
      connect "$DEFAULT"
      ;;
    *)
      connect "$opt"
      ;;
  esac
done
