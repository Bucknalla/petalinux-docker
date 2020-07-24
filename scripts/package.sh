#!/bin/bash

petalinux-package --boot --force --pmufw /home/vivado/project/rtl/xilinx/zc104.sdk/pmufw/Debug/pmufw.elf --fsbl ./images/linux/zynqmp_fsbl.elf --fpga ./images/linux/linux_bd_wrapper.bit --u-boot