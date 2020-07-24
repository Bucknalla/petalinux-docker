#!/bin/bash
PROJECT="$HOME/GitHub/lepton-core"
CUR_DIR=$(pwd)

docker run -ti --rm -e DISPLAY=$DISPLAY --net="host" -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/home/vivado/.Xauthority -v ${PROJECT}:/home/vivado/project -v ${CUR_DIR}/bsp:/home/vivado/bsp -v ${CUR_DIR}/peta:/home/vivado/peta/ -v ${CUR_DIR}/scripts:/home/vivado/scripts -v ${CUR_DIR}/drivers:/home/vivado/drivers petalinux:2018.3 /bin/bash

# docker exec mycontainer /path/to/test.sh
# petalinux-create -t project -s ../bsp/xilinx-zcu104-v2018.3-final.bsp