# tmux Configuration

A customized tmux configuration with vim-style keybindings, enhanced clipboard support for macOS, and a session management script.

## Installation

```bash
make install
# or directly:
zsh install.zsh
```

This will:
- Symlink `tmux.conf` to `~/.tmux.conf`
- Symlink `MacOStmux.conf` to `~/.MacOStmux.conf` (loaded automatically on macOS)
- Install the session manager script to `/usr/local/bin/t`
- Install `reattach-to-user-namespace` via Homebrew on macOS (if not present)

## Quick Reference

### Prefix Key

The prefix key is **`Ctrl-q`** (instead of the default `Ctrl-b`).

All commands below should be preceded by the prefix unless noted with `-n` (no prefix needed).

### Session Management

| Command | Description |
|---------|-------------|
| `t` | Launch session manager (select/create sessions) |
| `t <name>` | Connect to session by name |
| `t <number>` | Connect to session by index |
| `PREFIX d` | Detach from current session |

### Window Operations

| Keybinding | Description |
|------------|-------------|
| `Ctrl-t` | Next window (no prefix needed) |
| `PREFIX c` | Create new window |
| `PREFIX &` | Kill current window |
| `PREFIX ,` | Rename current window |
| `PREFIX w` | List windows |
| `PREFIX T` | Move current window to position 1 |
| `PREFIX 1-9` | Switch to window by number |

### Pane Operations

| Keybinding | Description |
|------------|-------------|
| `PREFIX \|` | Split horizontally |
| `PREFIX -` | Split vertically |
| `Ctrl-f` | Cycle through panes (no prefix needed) |
| `Ctrl-z` | Toggle pane zoom (maximize/restore, no prefix needed) |
| `PREFIX x` | Kill pane (no confirmation) |

### Pane Navigation (Vim-style)

| Keybinding | Description |
|------------|-------------|
| `PREFIX h` | Move to left pane |
| `PREFIX j` | Move to pane below |
| `PREFIX k` | Move to pane above |
| `PREFIX l` | Move to right pane |

### Pane Resizing

| Keybinding | Description |
|------------|-------------|
| `PREFIX H` | Resize left by 5 |
| `PREFIX J` | Resize down by 5 |
| `PREFIX K` | Resize up by 5 |
| `PREFIX L` | Resize right by 5 |

### Copy Mode (Vim-style)

| Keybinding | Description |
|------------|-------------|
| `PREFIX [` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `y` | Copy selection to clipboard |
| `Enter` | Copy selection and exit copy mode |
| `PREFIX y` | Copy buffer to system clipboard |
| `PREFIX p` | Paste from system clipboard |
| `q` | Exit copy mode |

### Mouse Support

| Keybinding | Description |
|------------|-------------|
| `PREFIX m` | Enable mouse mode |
| `PREFIX M` | Disable mouse mode |

### Configuration

| Keybinding | Description |
|------------|-------------|
| `PREFIX r` | Reload configuration |
| `PREFIX C` | Clear screen and scrollback history |

## Tips

### Session Manager (`t` command)

The `t` script provides an interactive way to manage tmux sessions:

```bash
# Start interactive session selector
t

# Connect to session "work" (or default if not found)
t work

# Connect to session by number
t 2
```

When creating a new session, it automatically:
- Creates 2 windows
- Splits each window into 2 vertical panes
- Selects the first window and pane

### Scrollback

This config sets scrollback history to 1,000,000 lines. Use copy mode (`PREFIX [`) to scroll through history.

### True Color Support

True color (24-bit color) is enabled. If your terminal supports it, you'll get full color rendering in applications like vim/neovim.

### Window/Pane Indexing

Windows and panes start at index 1 (not 0), making them easier to reach on the keyboard.

### Status Bar

The status bar shows:
- **Right side**: Session name, date (MM/DD), and time (HH:MM)
- **Center**: Window list (current window highlighted in green)

## File Structure

```
.
├── tmux.conf         # Main configuration
├── MacOStmux.conf    # macOS-specific settings (clipboard)
├── tmux.start.sh     # Session manager script (installed as /usr/local/bin/t)
├── install.zsh       # Installation script
├── Makefile          # Make wrapper for installation
└── README.md         # This file
```

## Requirements

- tmux 2.1+ (2.6+ recommended for native clipboard support)
- zsh
- macOS: `reattach-to-user-namespace` (auto-installed by install script, optional for tmux 2.6+)

## Customization

Edit `~/.tmux.conf` after installation, then reload with `PREFIX r`.

For macOS-specific changes, edit `~/.MacOStmux.conf`.

## Cheat Sheet

### No-Prefix Keys (Direct Access)

| Key | Action |
|-----|--------|
| `Ctrl-q` | Prefix key (hold for all PREFIX commands) |
| `Ctrl-b` | Next window |
| `Ctrl-f` | Next pane |
| `Ctrl-z` | Zoom/unzoom current pane |

### Essential Commands (PREFIX + key)

| Key | Action |
|-----|--------|
| `d` | Detach session |
| `r` | Reload config |
| `C` | Clear screen + history |

### Windows (PREFIX + key)

| Key | Action |
|-----|--------|
| `c` | Create window |
| `&` | Kill window |
| `,` | Rename window |
| `w` | List windows |
| `T` | Move window to #1 |
| `1-9` | Go to window # |

### Panes (PREFIX + key)

| Key | Action |
|-----|--------|
| `\|` | Split horizontal |
| `-` | Split vertical |
| `x` | Kill pane |
| `h j k l` | Navigate (vim) |
| `H J K L` | Resize by 5 |

### Copy Mode (PREFIX + key)

| Key | Action |
|-----|--------|
| `[` | Enter copy mode |
| `]` | Paste buffer |
| `y` | Copy buffer to clipboard |
| `p` | Paste from clipboard |

### In Copy Mode

| Key | Action |
|-----|--------|
| `v` | Start selection |
| `y` | Copy & exit |
| `Enter` | Copy & exit |
| `q` | Exit |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next match |
| `N` | Previous match |

### Mouse (PREFIX + key)

| Key | Action |
|-----|--------|
| `m` | Mouse ON |
| `M` | Mouse OFF |

### Session Manager

| Command | Action |
|---------|--------|
| `t` | Interactive menu |
| `t work` | Attach to "work" |
| `t 2` | Attach to session #2 |
