<p align="center">
  <h1 align="center">CLI for Virsh</h1><br>
  <img src="https://www.berkbal.com/wp-content/uploads/2022/01/virt-create-cli.gif" align="right" height="325" width="500"></img>
</p>

# How does this work?
Its a shell script that makes easy to deploy kernel virtual machines and managing them. Its a cli interface. It typically sends parameters or variables to basic qemu commands like(virt install virsh edit etc.) Use as root or with **sudo.**

# Required Packages

- virt-install
- qemu-kvm
- libvirt-clients
- libvirt-daemon
- virtinst
- qemu
- bridge-utils
- virt-manager

# Installation

**Debian Based Distros**:
`apt-get update && apt-get install virt-install qemu-kvm libvirt-clients libvirt-daemon virtinst qemu bridge-utils virt-manager`

**Pacman**: `pacman -S virt-install qemu libvirt virt-install qemu bridge-utils virt-manager`

- `cd ~/Downloads`
- `git clone git@github.com:berkbal/virt-create-cli.git`
- `cd virt-create-cli`
- `mkdir -p /opt/images`
- `sudo cp virt-create-cli /usr/local/sbin`
- `sudo chmod +x /usr/local/sbin/virt-create-cli`
- Copy your iso or img files to `/opt/images` folder.
- `sudo virt-create-cli`
- Use deploy menu to deploy a kvm.

![kvm creator with cli](https://www.berkbal.com/wp-content/uploads/2022/01/virt_create_cli_berkbal.com_.png)
