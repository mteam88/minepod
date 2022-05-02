FROM gitpod/workspace-full-vnc

RUN sudo apt-get update && \
    sudo apt-get install -y libgtk-3-dev && \
    sudo rm -rf /var/lib/apt/lists/

RUN sudo apt-get update
RUN sudo apt-get install -y wget

RUN sudo dpkg --add-architecture i386
RUN sudo apt-get update

RUN sudo apt-get install -y software-properties-common gnupg2
RUN sudo wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN sudo apt-key add winehq.key
RUN sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
RUN sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport
RUN sudo apt update && sudo apt install -y --install-recommends winehq-stable