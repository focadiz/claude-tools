# claude-tools

Small zsh scripts for running Claude Code sessions on macOS with iTerm and tmux.

## claude-launcher

Opens a project in a centered iTerm window (50% width, full height), inside a
tmux session named after the folder, running
`claude --dangerously-skip-permissions --name <name> --remote-control <name>`.

- Attaches if the tmux session already exists.
- Adds `--continue` when the folder has earlier Claude conversations.

```sh
claude-launcher <folder> [name]   # open one project
claude-launcher --save            # record running Claude sessions, then wait until all are idle
claude-launcher --all             # reopen every recorded session (skips ones already open)
```

The saved list lives in `~/.config/claude-launcher/projects`. Typical use:
`--save` before a restart, `--all` after.

## claude-dispatch

**Untested sketch.** Moves GitHub stories through headless Developer and
Tester agents (`claude -p`), using labels on issues and PRs as the board:

```
issue: ready ─► in-dev ─► (PR opened)                 failure ─► blocked
PR:    needs-test ─► in-test ─► tested                 (you merge)
                            └─► changes-requested ─► in-dev ─► needs-test …
```

Set `REPO`, `APPROVER` and `CLONE` at the top, create the labels (command in
the script header), then try `claude-dispatch --once` on a test repo.
Only stories labelled `ready` by `APPROVER` are picked up; each job is capped
by time (`MAX_MINUTES`) and spend (`MAX_USD`), and nothing is ever merged.

## Install

```sh
brew tap focadiz/claude-tools https://github.com/focadiz/claude-tools
brew install claude-tools          # latest tagged release
brew install --HEAD claude-tools   # or the latest main
```

Brew asks you to trust the tap the first time:
`brew trust --formula focadiz/claude-tools/claude-tools`.

## Requirements

macOS, iTerm2, tmux, zsh, Claude Code; `gh` and `jq` for claude-dispatch.
Brew installs tmux, gh and jq; iTerm2 and Claude Code you install yourself.
