SRC_URI += "file://system-user.dtsi"
 
SRC_URI_append += " file://0001_add_dma_proxy_node.patch"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
