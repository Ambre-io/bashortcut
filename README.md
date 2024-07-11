# 🧰 BASHORTCUT - LINUX LAYER 4 DEVELOPERS

**Philosofy**: automate and shortcut repetitions to decrease charge and increase fluidity.

## ☀️ Features

- Customize **Mouse Speed**, **Sound**, **Energy**, App folder and notes
- Customize the **Dock** (bar with software icons)
- Install **Tmux**, **Git**, **Gedit**, **Docker**, **Spotify**, **JetBrains Toolbox**, **Go**, **NVM**, Mongo-Compass
- Install BASHORTCUT and Load **Aliases**, **Prompt** and **Development Tools**
- Each cool part of the **Setup** is individually a **Command**

## 📖 Plan

- [Setup & Cleanup](#-setup--cleanup)
- [Commands](#-commands)
- [Bash Prompt](#-bash-prompt)
- [Tmux Boilerplate](#-tmux---terminal-multiplexer---boilerplate)
- [Bash Aliases](#-bash-aliases)

## 📜 Setup & Cleanup

The Setup script ask iteratively questions to setup the OS and install tools.
At the end of the process it asks for the BASHORTCUT install.

**Precisions**: BASHORTCUT is based on the `${HOME}/.bashrc`. The setup script create a conditioned source of
the [.bash_profile](https://github.com/Ambre-io/bashortcut/blob/main/linux/.bash_profile) in the `${HOME}/.bashrc` file.
Then, BASHORTCUT is loaded on the fly in each new session.

The Cleanup script remove this link. It still needs rework.

- ### ⚙️ **Local Install**: execute the [setup.sh](https://github.com/Ambre-io/bashortcut/blob/main/setup.sh) script

```bash
cd ${HOME}
git clone https://github.com/Ambre-io/bashortcut.git
sh setup.sh
```

- ### ⬇️ **Local Update**: perform a git pull (or fetch + merge)

```bash
cd ${BASHORCUT}
git checkout main
git pull
```

- ### 🗑️ **Local Delete**: execute the [cleanup.sh](https://github.com/Ambre-io/bashortcut/blob/main/cleanup.sh) script

```bash
cd ${BASHORTCUT}
sh cleanup.sh
```

- ### 💡 **Try** in a docker image

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

## 🛠️ Commands

### [Commands](https://github.com/Ambre-io/bashortcut/tree/main/commands) are usefull tools in a standalone way. Not activated by default.

| Command                          | Description                                                   |
|----------------------------------|---------------------------------------------------------------|
| **shortcuted.sh**                | Create a symlink for a given file in /usr/local/bin.          | 
| **create_tmux_session.sh**       | CLI to create a tmux session (alpha).                         | 
| **customize_dock.sh**            | CLI to custom the Dock (position, size...).                   |  
| **customize_git_user.sh**        | CLI to change the git user in global config.                  |  
| **customize_os.sh**              | CLI to custom Mouse speed, Sound, Battery and notes.          |   
| **customize_resolution.sh**      | Change the current resolution to 1920x1080 by default.        |  
| **customize_bashortcut.sh**      | Load Aliases and Prompt.                                      |  
| **install_curl.sh**              | Install curl.                                                 | 
| **install_docker.sh**            | Install and Launch Docker Engine.                             | 
| **install_gedit.sh**             | Install Gedit if not already installed.                       | 
| **install_git.sh**               | Install Git and Configure initial user.                       | 
| **install_go.sh**                | Clean install of latest Go lang version.                      | 
| **install_jetbrains_toolbox.sh** | Clean install of latest JetBrains Toolbox.                    | 
| **install_mongocompass.sh**      | Install latest Mongo-Compass.                                 | 
| **install_nvm.sh**               | Install latest Node Version Manager and Node.                 | 
| **install_spotify.sh**           | Install Spotify for the flow.                                 | 
| **install_tmux.sh**              | Install [Tmux](#4-tmux---terminal-multiplexer---boilerplate). | 
| **install_zfs_alert.sh**         | Check if everything is ok on a ZFS pool.                      |

### 2 ways to activate a command on demand:

- `sudo ln -s ${BASHORTCUT}/commands/<command_name.sh> /usr/local/bin`

or

- `shortcuted.sh ${BASHORTCUT}/commands/<command_name.sh>` (
  with `sudo ln -s ${BASHORTCUT}/commands/shortcuted.sh /usr/local/bin`)

## 🖥️ Bash Prompt

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

## 🪟 Tmux - Terminal Multiplexer - Boilerplate

Before, I turned on all my dev tools for 15 minutes every morning. Now, I type 2 letters of an autocomplete command
that launches the whole working environment and I take these 15 minutes to have a coffee with my colleagues, thanks to a
tmux session.

### A Tmux session is a set of windows and panes that can be saved and restored in a shell script:

- windows 0: run editors and tools
- windows 1: show frontend git status
- windows 2: run frontend server and logs
- windows 3: show backend git status
- windows 4: run backend server and logs
- windows 5: show bashortcut status
- windows 6: work (generic one with the Zen of Python)

### Boilerplate - Create your own Tmux session:

- Find the tmux config file [.tmux.conf](https://github.com/Ambre-io/bashortcut/blob/main/tmux/.tmux.conf) and a tmux
  session [tmux/example](https://github.com/Ambre-io/bashortcut/blob/main/tmux/example)
- Try locally the example tmux session with `./example`
- Create your session by copying the `example` file or using `create_tmux_session.sh` command
- Put your sessions in `sessions/` gitignored folder
- Don't forget to link your new sessions `shortcuted.sh ${BASHORTCUT}/tmux/sessions/<session_name>`
- Incr: https://tmuxcheatsheet.com/

## 💨 Bash Aliases

At first, it was a brilliant R&D colleague who introduced me to aliases and showed me how to use them very quickly.
I liked it so much, I instantly created my own. They respond to my way of thinking and my needs.
Sometimes it's for speed but other times it's because I don't feel like remembering or writing a giga command when I can
click on a single letter to do the same thing.

If you want to learn them it's in [.bash_aliases](https://github.com/Ambre-io/bashortcut/blob/main/linux/.bash_aliases)
directly, if not, I'm happy to share that.

## 📋 TODO

- [ ] Plank Dock arguments
- Appearance > Icon Zoom
- Behavior > Hide Dock
- [ ] Custom Top Panel
- change size to 24 (height)
- change Transparency to Always
- shadow Node
- Applets : (start) AppMenu, ShowTime, (center) Clock, Weather Show, (end) Show Desktop Button, AppIndicatorApplet,
  Keyboard Layout, Network, Status Indicator, Separator, User Indicator, Raven Trigger
- [ ] Cleanup Script
- Soft cleanup
- Hard cleanup
- [ ] Custom Firefox
- Disable alt
- [ ] Find a way to save private Tmux sessions and retrieve them easily
- [ ] Customize gThumb
- Viewer > Mouse wheel action > Zoom image
- shortcuts > viewer > show next file <=> Right
- shortcuts > viewer > show previous file <=> Left
- shortcuts > viewer > show first file <=> space
