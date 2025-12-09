#!/bin/sh

#ROOT="/sysroot"
ROOT="/"
MNT_AT="/.opensuse-merge-var/at"
MNT_ROOT="/.opensuse-merge-var/root"
FSTAB="${ROOT}/etc/fstab"
FINDMNT="/usr/bin/findmnt"
BTRFS="/usr/sbin/btrfs"

if ${FINDMNT} -F ${FSTAB} -n -M /var
then
	echo "Warning: /var mount point found, exiting..." >&2

	exit 0
fi

ROOT_DEVICE=$(${FINDMNT} -o SOURCE -nv ${ROOT})

echo "Info: root device ${ROOT_DEVICE}" >&2

mkdir -p "${MNT_AT}"
mkdir -p "${MNT_ROOT}"
mount -orw,subvol=@ "${ROOT_DEVICE}" "${MNT_AT}"
mount -orw "${ROOT_DEVICE}" "${MNT_ROOT}"
${BTRFS} subvolume create "${MNT_AT}/var.new"
chattr +C "${MNT_AT}/var.new"
cp --reflink=auto -a --preserve=all "${MNT_ROOT}/var/." "${MNT_AT}/var.new"
cp --reflink=auto -a --preserve=all "${MNT_AT}/var/." "${MNT_AT}/var.new"
sed -i.bak -e '0,/var/{/var/{h;s|/var/[\/0-9a-zA-Z]\+|/var|g;p;g}}' -e '/\/var\/[\/0-9a-zA-Z]\+/s/^/# /' "${MNT_ROOT}/etc/fstab"
mv "${MNT_AT}/var" "${MNT_AT}/var.bak"
mv "${MNT_ROOT}/var" "${MNT_ROOT}/var.bak"
mv "${MNT_AT}/var.new" "${MNT_AT}/var"
mkdir "${MNT_ROOT}/var"
umount "${MNT_ROOT}"
umount "${MNT_AT}"
