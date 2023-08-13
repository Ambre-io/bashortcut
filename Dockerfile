FROM ubuntu:22.04

RUN apt-get update && apt-get install -y sudo
RUN useradd -m bashortcuser && echo "bashortcuser:docker" | chpasswd && adduser bashortcuser sudo
USER bashortcuser

WORKDIR /home/bashortcuser
COPY ./ ./bashortcut/

USER root
RUN ln -s "/home/bashortcuser/bashortcut/tmux/example" "/usr/local/bin"

USER bashortcuser
