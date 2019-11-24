# vnc-container
This repository contains the necessary files to build a Docker image based on [Ubuntu 18.04](https://hub.docker.com/_/ubuntu) with the [Xfce4](https://www.xfce.org/) desktop and [TightVNC](https://www.tightvnc.com/licensing-tvnserver.php) server installed.  Along with this, notable convenience packages include Vim, Tmux, and Firefox.

## Building the Image
The simplest way to build an image named `ubuntu-vnc` is
```bash
docker build -t ubuntu-vnc .
```
What's above is also how the images on Docker Hub at [herter4171/ubuntu-vnc](https://hub.docker.com/repository/docker/herter4171/ubuntu-vnc) are built.

### With VNC Password Preset
Additionally, you have the option to bake in your desired VNC password at build-time by specifying the argument `VNC_PASS`.  For password `mypass`, the build command is as follows.
```bash
docker build --build-arg VNC_PASS=mypass -t ubuntu-vnc .
```
The content of `VNC_PASS` is used to invoke `vncpasswd` using [expect](https://linux.die.net/man/1/expect) at build-time to establish a fully configured image that can safely launch in a detached state.

## Using the Image
The main bit of nuance to using the image is that port 5901 must be open.  If the VNC password was not set at build-time, you'll want to run
```bash
docker run -ti -p 5901:5901 ubuntu-vnc
```
After hitting enter, you will be prompted to enter a VNC password, and the server will run until you exit out of the shell.

### With VNC Password Preset
If you did specify a VNC password using the build argument `VNC_PASS`, you can safely launch your container in a detached state like so. 
```bash
docker run -d -ti -p 5901:5901 ubuntu-vnc
```

## Security Note
The built image is designed to be run for the non-root user `dev`.  If you have reason to worry about attacks between your VNC client and the server, an SSH tunneling scheme of some kind is the standard way to lock things down.