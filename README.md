# vnc-container
This repository contains the necessary files to build a Docker image based on [Ubuntu 18.04](https://hub.docker.com/_/ubuntu) with the [Xfce4](https://www.xfce.org/) desktop and [TightVNC](https://www.tightvnc.com/licensing-tvnserver.php) server installed.  Along with this, notable convenience packages include Vim, Tmux, and Firefox.

## Building the Image
To build the image named `ubuntu-vnc`, the argument `VNC_PASS` must be passed in, e.g. for password `mypass`, the command is as follows.
```bash
docker build --build-arg VNC_PASS=mypass -t ubuntu-vnc .
```
This is done to invoke `vncpasswd` at build-time to establish a fully configured image.

## Using the Image
The only real nuance to using the image is that port 5901 must be open.
```bash
docker run -d -ti -p 5901:5901 ubuntu-vnc
```