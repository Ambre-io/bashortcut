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

- 💡 **Try**: use a docker image to try first (require docker installed)

```bash
# IN A LOCAL SHELL
cd ${HOME} && git clone https://github.com/guiklimek/bashortcut.git && cd bashortcut
docker compose build && docker run -it bashortcut bash
# IN A DOCKER IMAGE INTERACTIVE SHELL
bash bashortcut/setup.sh  # install script
# answer 'y' for tmux and git, 'n' for others
# password is 'docker'
source /home/bashortcuser/.bashrc  # then source as asked
cd bashortcut  # discover the prompt with git information
example  # discover the simple tmux session
```
- ⚙️ **Local Install**: execute the `setup.sh` script
```bash
cd ${HOME}
git clone https://github.com/guiklimek/bashortcut.git
sh setup.sh
```
- ⬆️ **Local Update**: perform a git pull (or fetch + merge)
```bash
cd ${BASHORCUT}
git checkout main
git pull
```
- 🗑️ **Local Delete**: execute the `cleanup.sh` script
```bash
cd ${BASHORTCUT}
sh cleanup.sh
```

## 2. Tmux Boilerplate
###### (~/bashortcut/tmux)

Before, I turned on all my dev tools for 15 minutes every morning. Now, I type 2 letters of an autocomplete command 
that launches the whole working environment and I take these 15 minutes to have a coffee with my colleagues. 
Thanks to a tmux session.

- Find the tmux config file `.tmux.conf` and a tmux session `example`
- Try the `example` tmux session locally with `./example`
- Put your sessions in `sessions/` gitignored folder
- Don't forget to link your new sessions `ln -s sessions/<nwone> /usr/local/bin`

## 3. Bash Prompt
###### (~/bashortcut/linux)

<span style="color:#55c6e7">[&lt;time&gt;]&lt;user&gt;@&lt;computer name&gt;</span><span style="color:#FFCC00FF">&lt;path&gt;</span><span style="color:#8CFF00FF">(&lt;git branch name&gt;)&lt;git sign&gt;</span> $

<span style="color:#55c6e7">[12:12:34]robinwilliams@linuxurian</span><span style="color:#FFCC00FF">~/Projects/sudokube3d</span><span style="color:#8CFF00FF">(main)↑</span> $

- branch and sign color depend on git status
- sign depends on git status
- **$** is the same color as the terminal text (Foreground) or red on error
- colors are customizable in the `.bash_prompt` file

## 4. Bash Aliases
###### (~/bashortcut/linux)

At first, it was a brilliant R&D colleague who introduced me to aliases and showed me how to use them very quickly.
I liked it so much, I instantly created my own. They respond to my way of thinking and my needs.
Sometimes it's for speed but other times it's because I don't feel like remembering or writing a giga command when I can click on a single letter to do the same thing.

If you want to learn them it's in `.bash_aliases` directly, if not, I'm happy to share that.

## 5. Commands
###### (~/bashortcut/commands)

It's like aliases in a standalone way:

| Commande   | Description                                            | Example                     | Symlink it                                                     |
|------------|--------------------------------------------------------|-----------------------------|----------------------------------------------------------------|
| shortcuted | Create a symlink for a given file in /usr/local/bin.   | `shortcuted home/path/file` | `sudo ln -s ${BASHORTCUT}/commands/shortcuted /usr/local/bin`  |
| guser      | CLI to change the git user in global config.           | `guser`                     | `shortcuted ${BASHORTCUT}/commands/guser`                      |
| resolution | Change the current resolution to 1920x1080 by default. | `resolution "1280x720"`     | `shortcuted ${BASHORTCUT}/commands/resolution`                 |

Not loaded by default.
