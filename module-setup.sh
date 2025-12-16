#!/bin/bash

# called by dracut
check() {
	return 255
}

# called by dracut
depends() {
	return 0
}

# called by dracut
installkernel() {
	return 0
}

# called by dracut
install() {
	inst_script "$moddir/opensuse-merge-var.sh" /bin/opensuse-merge-var.sh
	inst_simple "$moddir/opensuse-merge-var.service" "${systemdsystemunitdir}"/opensuse-merge-var.service
	inst_binary chattr

	mkdir -p "${initdir}/$systemdsystemunitdir/initrd-root-fs.target.wants"
        for i in opensuse-merge-var.service; do
		ln_r "$systemdsystemunitdir/${i}" "$systemdsystemunitdir/initrd-root-fs.target.wants/${i}"
        done
}
