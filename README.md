# dracut-opensuse-merge-var

## Description

`dracut-opensuse-merge-var` is a dracut module for **openSUSE distributions** that performs [unified `/var` submodule migration](https://lists.opensuse.org/opensuse-packaging/2017-11/msg00017.html).

## Disclaimer

This software is provided **"as is"**, without warranty of any kind. The developers are not responsible for any **data loss, system instability, or boot failures** resulting from its use.

**Recommendations:**
* Read and understand the module's source code before installation
* Maintain **current backups** and alternative boot methods

## Installation

1. Clone the module repository directly to the dracut modules directory:
   ```sh
   git clone https://github.com/matwey/dracut-opensuse-merge-var.git /usr/lib/dracut/modules.d/99opensuse-merge-var
   ```
2. Rebuild the initrd images, ensuring the newly installed module is included:
   ```sh
   dracut --force -a opensuse-merge-var
   ```
3. Reboot the system to apply the migration.

## Things to do after migration happened

1. Restore the previous initrd configuration:
   ```sh
   dracut --force
   ```
   The module includes safeguards, so it should be safe to boot multiple times with `opensuse-merge-var` enabled. However, you no longer need it in your initrd.

2. Cleanup commented out records in `/etc/fstab`.

3. Remove `/var.bak` directory and `/.var-merged` file.

4. Mount root subvolume
   ```sh
   mount -osubvol=@ /dev/sda3 /mnt/
   ```
   and drop all data including submodules at `/mnt/var.bak`.
