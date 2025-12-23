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
	inst_binary chattr
	inst_binary touch

	mkdir -p "/lib/dracut/hooks/pre-pivot"
	inst_script "${moddir}/opensuse-merge-var.sh" "/lib/dracut/hooks/pre-pivot/00-opensuse-merge-var.sh"
}
