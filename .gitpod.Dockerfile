FROM gitpod/workspace-full-vnc

RUN sudo apt-get update && \
    sudo apt-get install -y libgtk-3-dev && \
    sudo rm -rf /var/lib/apt/lists/

RUN sudo apt-get update && \
    wget https://launcher.mojang.com/download/Minecraft.deb && \
    sudo dpkg -i Minecraft.deb; exit 0 && \
    sudo apt -y install -f
