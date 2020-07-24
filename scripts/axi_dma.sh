#!/bin/bash

petalinux-create -t modules -n xilinx-axidma --enable

cp -a $HOME/axi_dma/driver/*.c $HOME/axi_dma/driver/*.h $HOME/axi_dma/include/axidma_ioctl.h project-spec/meta-user/recipes-modules/xilinx-axidma/files
rm project-spec/meta-user/recipes-modules/xilinx-axidma/files/xilinx-axidma.c