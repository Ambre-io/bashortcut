# BASHORTCUT

Funny way to use Linux environment, increasing happiness ☀️ with:
- [Setup & Cleanup](#1-setup--cleanup)
- [Tmux Boilerplate](#2-tmux-boilerplate)
- [Bash Prompt](#3-bash-prompt)
- [Bash Aliases](#4-bash-aliases)
- [Commands](#5-commands)

**Philosofy**: automate and shortcut repetitions to decrease charge and increase fluidity.

## 1. Setup & Cleanup

Linux environment based on the `~/.bashrc`:

- **Install**: execute the `setup.sh` script
```bash
mkdir ${HOME}/Projects  # Working dir
cd ${HOME}/Projects
git clone https://github.com/guiklimek/bashortcut.git
sh setup.sh
```
- **Update**: perform a git pull (or fetch + merge)
```bash
cd ${BASHORCUT}
git checkout main
git pull
```
- **Delete**: execute the `cleanup.sh` script
```bash
cd ${BASHORTCUT}
sh cleanup.sh
```
- 💡 **[in progress]** **Try**: use the docker compose to try the BASHORTCUT shell environment

## 2. Tmux Boilerplate
###### (~/Projects/bashortcut/tmux)

- Find the tmux config file `.tmux.conf` and a tmux session `example`
- Try the `example` tmux session locally with `./example`
- Put your sessions in `sessions/` gitignored folder
- Don't forget to link your new sessions `ln -s sessions/<nwone> /usr/local/bin`

## 3. Bash Prompt
###### (~/Projects/bashortcut/linux)


## 4. Bash Aliases
###### (~/Projects/bashortcut/linux)


## 5. Commands
###### (~/Projects/bashortcut/commands)

It's like aliases, in a **S**ingle **R**esponsability **A**lias way:

| Commande   | Description                                            | Example                     | Symlink it                                                     |
|------------|--------------------------------------------------------|-----------------------------|----------------------------------------------------------------|
| shortcuted | Create a symlink for a given file in /usr/local/bin.   | `shortcuted home/path/file` | `sudo ln -s ${BASHORTCUT}/commands/shortcuted /usr/local/bin`  |
| guser      | CLI to change the git user in global config.           | `guser`                     | `shortcuted ${BASHORTCUT}/commands/guser`                      |
| resolution | Change the current resolution to 1920x1080 by default. | `resolution "1280x720"`     | `shortcuted ${BASHORTCUT}/commands/resolution`                 |

Not loaded by default.
