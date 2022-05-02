FROM gitpod/workspace-full-vnc

RUN sudo apt-get update && \
    sudo apt-get install -y libgtk-3-dev && \
    sudo rm -rf /var/lib/apt/lists/

FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y wget

RUN dpkg --add-architecture i386
RUN apt-get update

RUN apt-get install -y software-properties-common gnupg2
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN apt-key add winehq.key
RUN apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
RUN add-apt-repository ppa:cybermax-dexter/sdl2-backport
RUN apt update && apt install -y --install-recommends winehq-stable