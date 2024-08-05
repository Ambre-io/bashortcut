# 🧰 BASHORTCUT - OS LAYER 4 DEVELOPERS

**Philosofy**: automate and shortcut repetitions to decrease charge and increase fluidity

## ☀️ Features

- Customize the OS: **Dock**, **Mouse Speed**, **Sound**, **Energy** and more...
- Install tools: **Visual Studio Code**, **Node.js**, **Git**, **Tmux**, **Docker**, **JetBrains Toolbox**,
**Go**, **Spotify** and more...
- Enhance the terminal experience: **BSHT profile**, **Aliases**, **Prompt** and **Commands**

Tested on Ubuntu Budgie 24.04 LTS.
Should be compatible at least with all Debian-based distributions.

## 📖 Plan

- [Setup & Cleanup](#-setup--cleanup)
- [BSHT Profile](#-bsht-profile)
    - [Prompt](#-prompt)
    - [Aliases](#-aliases)
- [Commands](#-commands)
- [Tmux Boilerplate](#-tmux---terminal-multiplexer---boilerplate)
- [TODO](#-todo)

## 📜 Setup & Cleanup

The Setup script ask iteratively questions to customize the OS, install tools and install the BSHT profile.

The Cleanup script deactivate the BSHT profile and remove the tmux configuration.

### ⚙️ **Install**

```bash
cd ${HOME}
git clone https://github.com/Ambre-io/bashortcut.git
sh setup.sh
```

### ⬇️ **Update**

```bash
cd ${BASHORCUT}
git checkout main
git pull
```

### 🗑️ **Delete**

```bash
cd ${BASHORTCUT}
sh cleanup.sh
```

## ⭐ BSHT profile

The BSHT profile is a set of Prompt, Aliases and some Development Tools configuration that enhance
the terminal experience. This is the BSHT profile inking file in OS. It is included in the `.bashrc` file.

<p align="center">
    <img src="bsht/BSHT.png" width="500" />
</p>
<p align="center">
   <span style="color: #D724FF; font-size: 11px">BSHT profile, with the Prompt, using Aliases, in a Tmux session</span>
</p>

### 🖥️ Prompt

BSHT profile optimizes prompt usage with cursor placement, useful information and color coding based on terminal
profile:

</span><span style="color:#FFCC00FF">
ʙsʜᴛ</span><span style="color:#8CFF00FF"><span style="color:#55c6e7">[&lt;time&gt;]</span><span style="color:#55c6e7">
&lt;path&gt;</span><span style="color:#8CFF00FF">(&lt;git branch name&gt;)&lt;git sign&gt;</span> $

</span><span style="color:#FFCC00FF">
ʙsʜᴛ</span><span style="color:#8CFF00FF"><span style="color:#55c6e7">[12:12:34]</span><span style="color:#55c6e7">~
/bashortcut</span><span style="color:#8CFF00FF">(main)↑</span> $

- branch and sign color depend on git status
- sign depends on git status
- **$** is the same color as the terminal text (Foreground) or red on error
- colors are customizable in
  the [prompt.sh](https://github.com/Ambre-io/bashortcut/blob/main/bsht/prompt.sh#L147) file
- you can add the old `<user>@<computer name>` part in
  the [prompt.sh](https://github.com/Ambre-io/bashortcut/blob/main/bsht/prompt.sh#L147) file

### 💨 Aliases

At the beginning, in 2016, it was a brilliant R&D colleague who introduced me to aliases and showed me how to use them
very quickly.
The main goal is to follow the flow of ideas. I liked it so much, I instantly created my own.

There are now more than **120 Aliases** in the BSHT profile. To learn them you can:

- use `oops` in a terminal using BSHT profile
- read them in the [aliases.sh](https://github.com/Ambre-io/bashortcut/blob/main/bsht/aliases.sh) file

Then, when an alias becomme to big or too complex, it evolves into a command.

## 🛠️ Commands

Set of [Commands](https://github.com/Ambre-io/bashortcut/tree/main/commands)
(not loaded by default):

| Command                          | Description                                                  |
|----------------------------------|--------------------------------------------------------------|
| **create_tmux_session.sh**       | (alpha) CLI to create a tmux session.                        | 
| **customize_dock.sh** 👣         | CLI to custom the Dock (position, size...).                  |  
| **customize_git_user.sh**        | CLI to change the git user in global config.                 |  
| **customize_os.sh** 👣           | CLI to custom Mouse speed, Sound, Battery and notes.         |   
| **customize_resolution.sh**      | Change the current resolution to 1920x1080 by default.       |
| **exe_zfs_alert.sh**             | Check if everything is ok on a ZFS pool.                     |
| **install_bsht_profile.sh**      | Install Aliases and Prompt by loading the BSHT profile.      |  
| **install_curl.sh**              | Install curl.                                                | 
| **install_dbeaver.sh**           | Install DBeaver.                                             | 
| **install_docker.sh**            | Install and Launch Docker Engine.                            | 
| **install_gedit.sh**             | Install Gedit if not already installed.                      | 
| **install_git.sh**               | Install Git and Configure initial user.                      | 
| **install_go.sh**                | Clean install of latest Go lang version.                     | 
| **install_jetbrains_toolbox.sh** | Clean install of the latest JetBrains Toolbox.               | 
| **install_mongocompass.sh**      | Install latest Mongo-Compass.                                | 
| **install_nvm.sh**               | Install latest Node Version Manager and Node.                | 
| **install_spotify.sh**           | Install Spotify for the flow.                                | 
| **install_tmux.sh**              | Install [Tmux](#-tmux---terminal-multiplexer---boilerplate). | 
| **install_vscode.sh**            | Install Visual Studio Code.                                  |
| **shortcuted.sh**                | Create a symlink for a given file in /usr/local/bin.         | 

👣 gnome-based commands

### 2 ways to load a command

➡️ `shortcuted.sh ./<command.sh>`

➡️ `sudo ln -s ${BASHORTCUT}/commands/<command.sh> /usr/local/bin`

## 🪟 Tmux - Terminal Multiplexer - Boilerplate

Take 15 minutes to have a coffee while your tmux session launches all your work environment.

A Tmux session is a set of windows and panes in a terminal, executing commands that can be saved and restored in a shell
script:

- window 0: run editors and tools
- window 1: show frontend git status
- window 2: run frontend server and logs
- window 3: show backend git status
- window 4: run backend server and logs
- window 5: show bashortcut status
- window 6: work (generic one with the Zen of Python)

### Boilerplate

#### 1/ Installation & Configuration

Tmux is installed during the setup and the default BASHORTCUT config
file [.tmux.conf](https://github.com/Ambre-io/bashortcut/blob/main/tmux/.tmux.conf)
is symlinked.

If you skipped it you can redo it with the `install_tmux.sh` command.

#### 2/ Test an example

BASHORTCUT comes with a [Tmux example session](https://github.com/Ambre-io/bashortcut/blob/main/tmux/example).

You can try the example session by executing it in a terminal: `./${BASHORTCUT}/tmux/example`.

Use `tks` (`tmux kill-session`) to kill the session.

#### 3/ Create a session

Create your own session by copying the `example` file or using the not tested `create_tmux_session.sh` command.

You can put your sessions in the gitignored folder: `${BASHORTCUT}/tmux/sessions/`.

And link it to use it from everywhere: `shortcuted.sh ${BASHORTCUT}/tmux/sessions/<session_name>`.

#### 4/ Helper

Classic Tmux usage: https://tmuxcheatsheet.com/.

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
