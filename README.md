<p align="center">
  <h1 align="center">CLI for Virsh</h1><br>
  <img src="https://www.berkbal.com/wp-content/uploads/2022/01/virt-create-cli.gif" align="right" height="325" width="500"></img>
</p>

# How does this work?
Its a shell script(cli interface) that makes easy to deploy kernel virtual machines and managing them. It typically sends parameters or variables to basic qemu commands like(virt install virsh edit etc.)

# Required Packages

- virt-install
- qemu-kvm
- libvirt-clients
- libvirt-daemon
- virtinst
- qemu
- bridge-utils
- virt-manager
- dialog
- whiptail

# Installation

**Debian Based Distros**:
`sudo apt-get update && sudo apt-get install qemu-kvm libvirt-clients libvirt-daemon virtinst qemu bridge-utils virt-manager dialog whiptail`

**If u use Arch btw**: `sudo pacman -S virt-install qemu libvirt virt-install qemu bridge-utils virt-manager virt-viewer dialog whiptail`

- `cd ~/Downloads`
- `git clone git@github.com:berkbal/virt-create-cli.git`
- `cd virt-create-cli`
- `sudo mkdir -p /opt/images`
- `sudo cp virt-create-cli /usr/local/bin`
- `sudo chmod +x /usr/local/bin/virt-create-cli`
- Copy your iso or img files to `/opt/images` folder.
- `sudo virsh net-start default`
- `sudo virt-create-cli`
- Use deploy menu to deploy a kvm.

![kvm creator with cli](https://www.berkbal.com/wp-content/uploads/2022/01/virt_create_cli_berkbal.com_.png)
