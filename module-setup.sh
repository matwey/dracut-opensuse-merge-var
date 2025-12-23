#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later

check() {
	return 255
}

depends() {
	return 0
}

installkernel() {
	return 0
}

install() {
	inst_binary chattr
	inst_binary touch

	mkdir -p "/lib/dracut/hooks/pre-pivot"
	inst_script "${moddir}/opensuse-merge-var.sh" "/lib/dracut/hooks/pre-pivot/00-opensuse-merge-var.sh"
}
