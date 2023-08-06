# BASHORTCUT

Funny way to use Linux, increasing my happiness ☀️ with:
- a turnkey setup script
- a turnkey cleanup script
- many aliases
- a custom bash prompt
- and a tmux config&use boilerplate

**Philosofy**: automate repetitions to decrease charge and increase fluidity.

## Install

```bash
mkdir ${HOME}/Projects
cd ${HOME}/Projects
git clone https://github.com/guiklimek/bashortcut.git
# cd bashortcut/linux
# sh setup.sh
```

## Linux
###### (~/Projects/bashortcut/linux)

A Linux environment, based on the `~/.bashrc`:

- Execute the `setup.sh` script to **install** BASHORTCUT environment
- Execute the `cleanenv.sh` script to **remove** BASHORTCUT environment (care of your `~/notes`)

## Tmux
###### (~/Projects/bashortcut/tmux)

- Find the tmux config file `.tmux.conf` and a tmux session `example`
- Try the `example` tmux session:
  - Execute `linux/postsetup.sh && source`
  - Then execute `example`
- Put your sessions in `sessions/` gitignored folder
- Don't forget to link your new sessions `ln -s sessions/<nwone> /usr/local/bin`

## Commands
###### (~/Projects/bashortcut/commands)

- Change screen resolution:`sudo ln -s ${BASHORTCUT}/commands/resolution /usr/local/bin`
- Change git user: `sudo ln -s ${BASHORTCUT}/commands/change-user-git /usr/local/bin`
- The command that `ln -s` for us: `sudo ln -s ${BASHORTCUT}/commands/shortcuted /usr/local/bin`...
