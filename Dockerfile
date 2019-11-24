FROM ubuntu:18.04

# Set working directory and copy shell script(s)
WORKDIR /root
COPY package_installs.sh .

# Run package installs
RUN ./package_installs.sh

# Fix terminal panel shortcut
RUN sed -i 's|Exec=exo-open --launch TerminalEmulator|Exec=/usr/bin/xfce4-terminal|g' \
/usr/share/applications/exo-terminal-emulator.desktop

# Set solid blue background (should reduce latency)
COPY background.jpg /usr/share/backgrounds/xfce/xfce-teal.jpg

# Set up new non-sudo user dev
RUN useradd dev ; \
mkdir /home/dev ; \
chown -R dev:dev /home/dev ; \
chsh -s /bin/bash dev
USER dev
ENV USER=dev
WORKDIR /home/dev

# Optional presetting of dev's VNC password
COPY fill_vnc_pass.exp .
ARG VNC_PASS=""
RUN if [ ! -z $VNC_PASS ]; then ./fill_vnc_pass.exp ${VNC_PASS}; fi

# This doesn't do much, but it's good formality and for clarity of intent
EXPOSE 5901

# Preset VNC config
RUN printf "\$geometry = \"1920x1080\";" > .vncrc ; \
mkdir -p .vnc && cd .vnc ; \
printf "startxfce4 &" > xstartup ; \
chmod +x xstartup

# Launch VNC server on container start
CMD vncserver ; /bin/bash