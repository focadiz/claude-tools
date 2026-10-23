# Product potential: is claude-tools useful to other developers?

Assessment written 2026-10-22, to explore further.

**Short answer:** some potential, but narrower than it looks today.
`claude-launcher` is closer to being useful to others; `claude-dispatch` is the
more interesting idea but has to prove itself first.

## claude-launcher: a real problem, a small audience

**For it**
- **The problem is common.** Many people run several long-lived Claude Code
  sessions and lose them on every reboot or update. "Save my sessions, wait
  until they're idle, bring them all back with their conversations" is a
  one-sentence benefit.
- **It's simple.** One zsh file, no background service, built on tmux and
  Claude's own `--continue`. Easy to trust and easy to read.
- **Its edge:** the "wait until idle before restarting" step in `--save`.
  tmux-resurrect, herdr and claude-squad don't appear to offer it.

**Against it**
- **Tied to one setup.** Needs macOS and iTerm, and always starts Claude with
  personal flags (`--dangerously-skip-permissions`, `--remote-control`). Many
  developers use Ghostty, kitty, WezTerm or Linux, and many won't want
  permission checks off by default.
- **Fragile parts.** Busy detection reads Claude's screen text ("esc to
  interrupt"); finding past conversations looks inside Claude's internal folder
  (`~/.claude/projects/`). Either can break with a Claude update.
- **Competition.** tmux-resurrect restores sessions after a reboot, herdr is
  aiming at agent-aware sessions, and Claude Code itself changes quickly. Any of
  these could make the core feature unnecessary.

## claude-dispatch: a good idea in a busy field

**For it:** GitHub labels as the record of each story's state, a human who
approves work and merges it, a time and spending cap per job, and only the
script moving work between stages. These answer the usual worries about
unattended agents.

**Against it:** the space is crowded and moving fast (Anthropic's Claude Code
GitHub Action plus many orchestration tools), and it's an untested sketch.
Nobody will adopt it before it has run reliably on a real repository for a while.

## What would make it worth sharing

1. **Your own flags:** a config file for `claude` options, window size and
   terminal, instead of personal settings built into the script.
2. **More terminals:** at least Terminal.app and Ghostty, or a "tmux only, no
   window" mode that also works on Linux and over SSH.
3. **Tolerating Claude changes:** switch to an official way of reading session
   status and listing past conversations if Claude ever provides one.
4. **Proving the dispatcher:** run it on a real project for a few weeks and
   write up what broke. That write-up is what convinces other people.
5. **Public-project basics:** a license, a short demo GIF (reboot, then `--all`
   restoring everything), a public repo with a brew tap.

## Recommendation

After items 1 and 5, publish `claude-launcher` as a small utility that does one
thing well, and test interest with a Show HN post or in the Claude Code
community. Keep `claude-dispatch` private until it has been used on real work.

## Related open items

- Packaging: a Homebrew formula in this repo (`Formula/claude-tools.rb`,
  installed via `brew tap focadiz/claude-tools <repo URL>`) works even while the
  repo is private, because brew clones it with git.
- Before brew installs: move claude-dispatch's `REPO`/`APPROVER`/`CLONE`
  settings into `~/.config/claude-dispatch/config`, so upgrades don't wipe them
  and real values stay out of git.
