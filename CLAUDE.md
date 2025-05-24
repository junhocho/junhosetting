# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal development environment setup repository for configuring Unix-like systems (primarily Ubuntu/Linux) with a complete CLI-based development stack. The repository provides automated installation and configuration scripts for zsh, tmux, vim/neovim, and various development tools.

## Key Commands

### Initial Setup
- `./setup-all.sh` - Complete environment setup (run in clean user environment, exit after zsh install to continue)
- `./setup-zsh.sh` - Install and configure zsh with oh-my-zsh and syntax highlighting
- `./neovim-install.sh` - Install neovim with vim-plug and essential plugins
- `./setup-anaconda.sh` - Install Python/Anaconda environment

### Environment Management
- tmux configuration sourced from `~/junhosetting/tmux.conf`
- vim configuration sourced from `~/junhosetting/vimrc`
- Custom aliases sourced from `~/junhosetting/my-alias.sh`

### Key Aliases (from my-alias.sh)
- `ta`, `ta0`, `ta1` - tmux attach shortcuts
- `tn` - tmux new session
- `grepn` - grep with line numbers and color
- `wn` - watch nvidia-smi
- `jp` - jupyter notebook --no-browser
- `zshreload` - reload zsh configuration

## Architecture

### Configuration Approach
- Uses sourcing strategy instead of copying files (e.g., `echo 'source ~/junhosetting/tmux.conf' > ~/.tmux.conf`)
- Allows for easy updates by pulling repository changes without reconfiguring dotfiles
- All configurations point back to this repository for centralized management

### Core Components
1. **Shell Environment**: zsh with oh-my-zsh, custom aliases, and syntax highlighting
2. **Terminal Multiplexer**: tmux with vim-like key bindings, custom status bar, session resurrection
3. **Editor**: neovim with extensive plugin ecosystem via vim-plug
4. **Version Control**: Git with configured user settings and core editor
5. **Development Tools**: Python/Anaconda, Docker integration, PyTorch installation scripts

### Tmux Configuration
- Prefix changed to Ctrl+a
- Vim-style pane navigation (h,j,k,l)
- Session resurrection with tmux-resurrect plugin
- Custom status bar with hostname and session info
- Mouse support enabled

### Vim/Neovim Setup
- Uses vim-plug for plugin management
- Key plugins: NERDTree, CtrlP, airline, syntastic, vim-fugitive, GitHub Copilot
- Leader key mapped to comma (,)
- Extensive buffer management shortcuts
- Git integration with signify and fugitive
- Function keys mapped for common operations (F1-F9)

### SSH Configuration
- Repository includes multiple SSH public keys for server access
- Setup instructions for GitHub authentication with SSH keys

## Development Workflow

When modifying this repository:
1. Test changes on a clean system or container
2. Ensure all scripts remain idempotent where possible
3. Update source references if moving or renaming configuration files
4. Verify tmux/vim plugin compatibility after updates