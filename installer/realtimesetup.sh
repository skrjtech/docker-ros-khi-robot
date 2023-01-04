#!/bin/bash
wget https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1-rc7-rt5.patch.gz
gzip -cd ../patch-6.1-rc7-rt5.patch.gz | patch -p1 --verbose
make menuconfig
make-kpkg -j 8 --rootcmd fakeroot --initrd kernel_image kernel_headers
cd ..
sudo dpkg -i linux-headers-5.4.13-rt7_5.4.13-rt7-10.00.Custom_amd64.deb linux-image-5.4.13-rt7_5.4.13-rt7-10.00.Custom_amd64.deb
