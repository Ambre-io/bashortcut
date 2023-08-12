# BASHORTCUT

Funny way to use Linux, increasing happiness ☀️ with:
- Setup & Cleanup
- Bash Aliases
- Bash Prompt
- Tmux Boilerplate
- Commands

**Philosofy**: automate and shortcut repetitions to decrease charge and increase fluidity.

<!-- ## Try in a Docker container: -->

## 1. Install

```bash
mkdir ${HOME}/Projects  # Working dir
cd ${HOME}/Projects
git clone https://github.com/guiklimek/bashortcut.git
# cd bashortcut/linux
# sh setup.sh
```

## 2. Linux
###### (~/Projects/bashortcut/linux)

A Linux environment, based on the `~/.bashrc`:

- Execute the `setup.sh` script to **install** BASHORTCUT environment
- Execute the `cleanenv.sh` script to **remove** BASHORTCUT environment (care of your `~/notes`)

It includs: a bash prompt, bash aliases, git, tmux, docker and a tmux configuration.

## 3. Tmux
###### (~/Projects/bashortcut/tmux)

- Find the tmux config file `.tmux.conf` and a tmux session `example`
- Try the `example` tmux session locally with `./example`
- Put your sessions in `sessions/` gitignored folder
- Don't forget to link your new sessions `ln -s sessions/<nwone> /usr/local/bin`

## 4. Commands
###### (~/Projects/bashortcut/commands)

It's like aliases, in a **S**ingle **R**esponsability **A**lias way:

| Commande   | Description                                            | Example                     | Symlink it                                                     |
|------------|--------------------------------------------------------|-----------------------------|----------------------------------------------------------------|
| shortcuted | Create a symlink for a given file in /usr/local/bin.   | `shortcuted home/path/file` | `sudo ln -s ${BASHORTCUT}/commands/shortcuted /usr/local/bin`  |
| guser      | CLI to change the git user in global config.           | `guser`                     | `shortcuted ${BASHORTCUT}/commands/guser`                      |
| resolution | Change the current resolution to 1920x1080 by default. | `resolution "1280x720"`     | `shortcuted ${BASHORTCUT}/commands/resolution`                 |

Not loaded by default.
