FROM gitpod/workspace-full:latest

# Install Xvfb, JavaFX-helpers, Openbox window manager and emacs GTK
RUN sudo install-packages xvfb x11vnc xterm openjfx libopenjfx-java openbox \
            emacs-gtk

# Overwrite this env variable to use a different window manager
ENV WINDOW_MANAGER="openbox"

USER root

# Change the default number of virtual desktops from 4 to 1 (footgun)
RUN sed -ri "s/<number>4<\/number>/<number>1<\/number>/" /etc/xdg/openbox/rc.xml

# Install novnc
RUN git clone --depth 1 --single-branch --branch pointer-lock-api https://github.com/lhchavez/noVNC.git /opt/novnc \
    && git clone --depth 1 https://github.com/novnc/websockify /opt/novnc/utils/websockify
COPY /gitpod/workspace/novnc-index.html /opt/novnc/index.html

# Add VNC startup script
COPY /gitpod/workspace/start-vnc-session.sh /usr/bin/
RUN chmod +x /usr/bin/start-vnc-session.sh

# This is a bit of a hack. At the moment we have no means of starting background
# tasks from a Dockerfile. This workaround checks, on each bashrc eval, if the X
# server is running on screen 0, and if not starts Xvfb, x11vnc and novnc.
RUN echo "export DISPLAY=:0" >> ~/.bashrc
RUN echo "[ ! -e /tmp/.X0-lock ] && (/usr/bin/start-vnc-session.sh &> /tmp/display-\${DISPLAY}.log)" >> ~/.bashrc

### checks ###
# no root-owned files in the home directory
RUN notOwnedFile=$(find . -not "(" -user gitpod -and -group gitpod ")" -print -quit) \
    && { [ -z "$notOwnedFile" ] \
        || { echo "Error: not all files/dirs in $HOME are owned by 'gitpod' user & group"; exit 1; } }

USER gitpod

RUN sudo apt-get update && \
    sudo apt-get install -y libgtk-3-dev && \
    sudo rm -rf /var/lib/apt/lists/

RUN sudo apt-get update && \
    wget https://launcher.mojang.com/download/Minecraft.deb && \
    sudo dpkg -i Minecraft.deb; exit 0 && \
    sudo apt -y install -f
