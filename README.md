# tmux Configuration

Customized tmux setup with vim-style pane movement, macOS clipboard integration, and a session launcher script.

## Source of Truth

`tmux.conf` is the source of truth for behavior and keybindings.

- If this README conflicts with `tmux.conf`, follow `tmux.conf`.
- Keep docs in sync by updating this README whenever `tmux.conf` changes.

## Installation

```bash
make install
# or directly
zsh install.zsh
```

This installs:
- `tmux.conf` -> `~/.tmux.conf`
- `MacOStmux.conf` -> `~/.MacOStmux.conf` (macOS only, auto-loaded)
- `tmux.start.sh` -> `/usr/local/bin/t`

## Prefix

Prefix is `Ctrl-q` (default `Ctrl-b` is unbound).

## No-Prefix Keybindings (`bind -n`)

| Key | Action |
|---|---|
| `Meta-z` | Toggle zoom for current pane |
| `Meta-f` | Select next pane |
| `Meta-t` | Select next window |
| `Meta-q` | Open window tree chooser (`choose-tree`) |
| `Meta-Q` | In tree mode only: move selection up |
| `Meta-w` | Jump to pane 1 in current window and ensure zoomed |
| `Meta-e` | Jump to pane 2 in current window and ensure zoomed |
| `Meta-s` | Jump to pane 3 in current window and ensure zoomed |
| `Meta-d` | Jump to pane 4 in current window and ensure zoomed |
| `Ctrl-u` | Enter copy mode and scroll up |

Notes for `Meta-q` tree chooser:
- Starts with windows collapsed.
- Sorted by name.
- Sends one `Right` key after opening.
- Selecting an item switches to it and zooms if not already zoomed.

## Prefix Keybindings

| Key | Action |
|---|---|
| `r` | Reload `~/.tmux.conf` |
| `C` | Clear screen + clear history |
| `\|` | Split horizontally |
| `-` | Split vertically |
| `T` | Move current window to index 1 |
| `x` | Kill current pane |
| `h` `j` `k` `l` | Select pane left/down/up/right |
| `H` `J` `K` `L` | Resize pane by 5 cells |
| `Ctrl-q` | Send prefix through to app |

## macOS Clipboard Bindings

Configured in `MacOStmux.conf`:

| Context | Key | Action |
|---|---|---|
| copy-mode-vi | `v` | Begin selection |
| copy-mode-vi | `y` | Copy selection to macOS clipboard and exit |
| copy-mode-vi | `Enter` | Copy selection to macOS clipboard and exit |
| prefix | `y` | Copy tmux buffer to macOS clipboard |
| prefix | `Ctrl-y` | Copy tmux buffer to macOS clipboard |
| prefix | `p` | Paste from macOS clipboard |

## Session Manager (`t`)

`t` is installed from `tmux.start.sh`.

Examples:

```bash
t
t work
t 2
```

When creating a session, it creates:
- Window 1: 2x2 panes
- Window 2: 2x2 panes
- Focus returns to window 1, top-left pane

## Other Behavior

- `history-limit` is `1000000`
- `base-index` and `pane-base-index` are `1`
- `mouse` is `on`
- `mode-keys` is `vi`
- true color is enabled (`Tc` override)

## Files

```text
tmux.conf        # main config
MacOStmux.conf   # macOS clipboard/copy-mode extras
tmux.start.sh    # session launcher (installed as `t`)
install.zsh      # installer
Makefile         # install wrapper
README.md        # documentation
```
