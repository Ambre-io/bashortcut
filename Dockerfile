FROM ubuntu:22.04 as base

RUN groupadd -r bashortcuser --gid=1280
RUN useradd -r -g bashortcuser --uid=1280 --create-home --shell /bin/bash bashortcuser

USER bashortcuser

WORKDIR /home/bashortcuser

COPY ./ ./Projects/bashortcut/

USER root

RUN ln -s "/home/bashortcuser/Projects/bashortcut/tmux/example" "/usr/local/bin"

USER bashortcuser
