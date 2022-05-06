FROM mteam88/workspace-vnc-full:full-vnc

RUN sudo apt-get update && \
    sudo apt-get install -y libgtk-3-dev && \
    sudo rm -rf /var/lib/apt/lists/

# Install novnc
RUN sudo rm -rf /opt/novnc \
    && sudo git clone --depth 1 https://github.com/mteam88/noVNC /opt/novnc \
    && sudo git clone --depth 1 https://github.com/novnc/websockify /opt/novnc/utils/websockify

RUN sudo apt-get update && \
    wget https://launcher.mojang.com/download/Minecraft.deb && \
    sudo dpkg -i Minecraft.deb; exit 0 && \
    sudo apt -y install -f
