FROM gitpod/workspace-full-vnc

RUN sudo apt-get update && \
    sudo apt-get install -y libgtk-3-dev && \
    sudo rm -rf /var/lib/apt/lists/

RUN sudo apt-get update
RUN wget https://launcher.mojang.com/download/Minecraft.deb
RUN sudo dpkg -i Minecraft.deb; exit 0
RUN sudo apt install -f