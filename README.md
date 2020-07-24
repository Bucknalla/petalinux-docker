# petalinux-docker

Copy petalinux-v2018.1-final-installer.run file to this folder. Then run

```bash
export XIL_VERSION="2018.3"
docker build --build-arg PETA_VERSION=${XIL_VERSION} --build-arg PETA_RUN_FILE=download/petalinux-v${XIL_VERSION}-final-installer.run -t petalinux:${XIL_VERSION} .
```

After installation, launch petalinux with:

```bash
export PROJECT="$HOME/GitHub/lepton-core"
docker run -ti --rm -e DISPLAY=$DISPLAY --net="host" -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/home/vivado/.Xauthority -v ${PROJECT}:/home/vivado/project  petalinux:2018.3 /bin/bash
```