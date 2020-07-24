proc generate_dts {hdf} {
	if {[glob -nocomplain -types d repo] == ""} {
		puts "Please create the DTG:"
		puts "\tmkdir -p repo/my_dts"
		puts "\tcd repo/my_dts"
		puts "\tgit clone https://github.com/Xilinx/device-tree-xlnx"
		puts "\tcd device-tree-xlnx"
		puts "\tgit checkout xilinx-v2018.3 \n"
		puts "\tgit apply 0001_add_cell_info.patch \n"
		return 0
	} else {
		set hw [hsi::open_hw_design $hdf]
		set proc [select_proc]
		if {$proc != -1} {
			hsi::set_repo_path ./repo
			hsi::create_sw_design sw1 -proc $proc -os device_tree
			hsi::set_property CONFIG.dt_overlay true [hsi::get_os]
			hsi::generate_bsp -dir dtg_out
		} else {
			puts "No devicetree will be created \n"
			return 0
		}
		hsi::close_hw_design $hw
	}
	if {[check_dtc_version] == 0} {
			puts "Unsupported version of DTC. User must use version greater than 1.4.3"
			puts "\tgit clone https://git.kernel.org/pub/scm/utils/dtc/dtc.git"
			puts "\tcd dtc"
			puts "\tgit checkout v1.5.0"
			puts "\tmake"
			puts "\texport PATH=$PATH:/<Your Path>/dtc \n"
	} else {
		exec dtc -I dts -O dtb -o pl.dtbo -b 0 -@ dtg_out/pl.dtsi
	}
}

#assumed that the HW design is already open
proc select_proc {} {
	set family [common::get_property FAMILY [hsi::current_hw_design]]
	if {$family == "zynq"} {
		return ps7_cortexa9_0
	} elseif {$family == "zynquplusRFSOC" || $family == "zynquplus"} {
		return psu_cortexa53_0
	} else {
		puts "Error: Unsupport Family $family \n"
		return -1
	}
}

#Users need to use DTC version greater than v1.4.3
proc check_dtc_version {} {
	set dtc_version [split [exec dtc --version] " "]
	set dtc_version [lindex $dtc_version [expr {[llength $dtc_version]-1}]]
	set dtc_version [split $dtc_version .]
	set rev_major [lindex $dtc_version 1]
	set rev_minor [lindex $dtc_version 2]
	if {$rev_major < 4} {
		return 0
	} else {
		return 1
	}
	if {$rev_minor < 3} {
		return 0
	} else {
		return 1
	}
}

proc bit2bin {file} {
	if {[file extension $file] == ".hdf"} {
		hsi::open_hw_design $file
		set bit [glob -nocomplain -directory [file dirname $file] -types f [file rootname [file tail $file]].bit]
		if {[llength $bit] > 1} {
			set bit [lindex $bit 0]
			puts "Warning: More than 1 bit file found, script will use $bit"
			puts "If this is not correct, then use bit2bin <path to bit file>.bit instead"
		}
		set proc [select_proc]
		hsi::close_hw_design [hsi::current_hw_design]
	} else {
		puts "Error: Unknown file ${file}. Please use a HDF file"
		return -1
	}
	if {$bit != ""} {
		set outputFile [open bootgen.bif w]
		puts $outputFile "all:"
		puts $outputFile "{"
		if {$proc == "psu_cortexa53_0"} {
		puts $outputFile "\t\[destination_device = pl\] $bit"
		} else {
		puts $outputFile "\t$bit"
		}
		puts $outputFile "}"
		close $outputFile
		if {$proc == "psu_cortexa53_0"} {
			exec bootgen -arch zynqmp -image bootgen.bif -process_bitstream bin -w on
		} elseif {$proc == "ps7_cortexa9_0"} {
			exec bootgen -arch zynq -image bootgen.bif -process_bitstream bin -w on
		} else {
			puts "Error: Unsupport Family $family \n"
		}
		puts "${bit}.bin file created successfully"
		file copy -force ${bit}.bin .
	} else {
		puts "No bitstream found in $file"
	}
}

generate_dts /home/vivado/project/rtl/xilinx/zc104.sdk/design_1_wrapper.hdf
bit2bin /home/vivado/project/rtl/xilinx/zc104.sdk/design_1_wrapper.hdf
