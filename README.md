# BASHORTCUT - LINUX LAYER

### ☀️ It's a linux layer that help to Setup, Customize and Use for developers
Tested on Ubuntu Budgie 24.04. Can be used on Ubuntu, Debian and linux-using-shell-like.

## 🚀 Features

- Customize **Mouse Speed**, **Sound**, **Energy**, App folder and notes
- Customize the **Dock** (bar with software icons)
- Install **Tmux**, **Git**, **Gedit**, **Docker**, **Spotify**, **JetBrains Toolbox**, **Go**, **NVM**, Mongo-Compass
- Install BASHORTCUT and Load **Aliases**, **Prompt** and **Development Tools**
- Each cool part of the **Setup** is individually a **Command**

## 📖 Plan

- [Setup & Cleanup](#1-setup--cleanup)
- [Commands](#2-commands)
- [Bash Prompt](#3-bash-prompt)
- [Tmux Boilerplate](#4-tmux-boilerplate)
- [Bash Aliases](#5-bash-aliases)


**Philosofy**: automate and shortcut repetitions to decrease charge and increase fluidity.

## 1. Setup & Cleanup

The Setup script ask iteratively questions to setup the OS and install tools. 
At the end of the process it asks for the BASHORTCUT install.

**Precisions**: BASHORTCUT is based on the `${HOME}/.bashrc`. The setup script create a conditioned source of
the [.bash_profile](https://github.com/Ambre-io/bashortcut/blob/main/linux/.bash_profile) in the `${HOME}/.bashrc` file. Then, BASHORTCUT is loaded on the fly in each new session.

The Cleanup script remove this link. It still needs rework.

- ⚙️ **Local Install**: execute the [setup.sh](https://github.com/Ambre-io/bashortcut/blob/main/setup.sh) script

```bash
cd ${HOME}
git clone https://github.com/Ambre-io/bashortcut.git
sh setup.sh
```

- ⬇️ **Local Update**: perform a git pull (or fetch + merge)

```bash
cd ${BASHORCUT}
git checkout main
git pull
```

- 🗑️ **Local Delete**: execute the [cleanup.sh](https://github.com/Ambre-io/bashortcut/blob/main/cleanup.sh) script

```bash
cd ${BASHORTCUT}
sh cleanup.sh
```

- 💡 **Try**: in a docker image

```bash
# IN A LOCAL SHELL
cd ${HOME} && git clone https://github.com/Ambre-io/bashortcut.git && cd bashortcut
docker compose build && docker run -it bashortcut bash
# IN A DOCKER IMAGE INTERACTIVE SHELL
bash bashortcut/setup.sh  # install script
# answer 'y' for tmux and git, 'n' for others
# password is 'docker'
source /home/bashortcuser/.bashrc  # then source as asked
cd bashortcut  # discover the prompt with git information
example  # discover the simple tmux session
```
## 2. Commands

[Commands](https://github.com/Ambre-io/bashortcut/tree/main/commands) are usefull tools in a standalone way. Not activated by default. Install and Use **shortcuted** to activate them.

| Command        | Description                                            | Example                           | Activate it (using a symlink)                                 |
|----------------|--------------------------------------------------------|-----------------------------------|---------------------------------------------------------------|
| **shortcuted** | Create a symlink for a given file in /usr/local/bin.   | `shortcuted <complete/path/file>` | `sudo ln -s ${BASHORTCUT}/commands/shortcuted /usr/local/bin` |
| guser          | CLI to change the git user in global config.           | `guser`                           | `shortcuted ${BASHORTCUT}/commands/guser`                     |
| resolution     | Change the current resolution to 1920x1080 by default. | `resolution "1280x720"`           | `shortcuted ${BASHORTCUT}/commands/resolution`                |



## 3. Bash Prompt

<span style="color:#55c6e7">[&lt;time&gt;]</span><span style="color:#FFCC00FF">
&lt;path&gt;</span><span style="color:#8CFF00FF">(&lt;git branch name&gt;)&lt;git sign&gt;</span> $

<span style="color:#55c6e7">[12:12:34]</span><span style="color:#FFCC00FF">~
/Projects/sudokube3d</span><span style="color:#8CFF00FF">(main)↑</span> $

- branch and sign color depend on git status
- sign depends on git status
- **$** is the same color as the terminal text (Foreground) or red on error
- colors are customizable in
  the [.bash_prompt](https://github.com/Ambre-io/bashortcut/blob/main/linux/.bash_prompt#L148) file
- you can add the old `<user>@<computer name>` part in
  the [.bash_prompt](https://github.com/Ambre-io/bashortcut/blob/main/linux/.bash_prompt#L148) file

## 4. Tmux Boilerplate

Before, I turned on all my dev tools for 15 minutes every morning. Now, I type 2 letters of an autocomplete command
that launches the whole working environment and I take these 15 minutes to have a coffee with my colleagues.
Thanks to a tmux session.

- Find the tmux config file [.tmux.conf](https://github.com/Ambre-io/bashortcut/blob/main/tmux/.tmux.conf) and a tmux
  session [example](https://github.com/Ambre-io/bashortcut/blob/main/tmux/example)
- Try locally the example tmux session with `./example`
- Put your sessions in `sessions/` gitignored folder
- Don't forget to link your new sessions `ln -s sessions/<nwone> /usr/local/bin`
- Incr: https://tmuxcheatsheet.com/

## 5. Bash Aliases

At first, it was a brilliant R&D colleague who introduced me to aliases and showed me how to use them very quickly.
I liked it so much, I instantly created my own. They respond to my way of thinking and my needs.
Sometimes it's for speed but other times it's because I don't feel like remembering or writing a giga command when I can
click on a single letter to do the same thing.

If you want to learn them it's in [.bash_aliases](https://github.com/Ambre-io/bashortcut/blob/main/linux/.bash_aliases)
directly, if not, I'm happy to share that.

## TODO 
add a choice for the prompt, aliases, profile (zfs) and commands.
