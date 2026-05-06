# tmux and Zellij Configuration

Customized tmux and Zellij setup with vim-style pane movement, macOS clipboard integration, and a `t` session launcher.

## Source of Truth

`tmux.conf` and `zellij/config.kdl` are the sources of truth for behavior and keybindings.

- If this README conflicts with those files, follow the config files.
- Keep docs in sync by updating this README whenever config behavior changes.

## Installation

```bash
make install
# or directly
zsh install.zsh
```

This installs:
- `tmux.conf` -> `~/.tmux.conf`
- `MacOStmux.conf` -> `~/.MacOStmux.conf` (macOS only, auto-loaded)
- `zellij.start.sh` -> `/usr/local/bin/t`
- `zellij/config.kdl` -> `~/.config/zellij/config.kdl`
- `zellij/layouts` -> `~/.config/zellij/layouts`

If `/usr/local/bin` is root-owned, installing the `t` launcher prompts for `sudo`.

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

`t` is installed from `zellij.start.sh` and manages Zellij sessions.

Examples:

```bash
t
t work
t 2
```

Behavior:
- Running `t` inside Zellij exits without nesting sessions.
- Running `t work` attaches to `work`, creating it if needed.
- Running `t 2` attaches to the second session in the menu list.
- Running `t` ensures `_default` exists and opens an interactive session menu.
- New session layout comes from Zellij's configured default layout.

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
tmux.start.sh    # legacy tmux session launcher
zellij.start.sh  # Zellij session launcher (installed as `t`)
install.zsh      # installer
Makefile         # install wrapper
README.md        # documentation
```
