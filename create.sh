#!/bin/bash

: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
function main_menu(){
	menu=$(whiptail --clear --title "    Virsh-Cli    " --menu "Choose an option" 40 100 10 \
		"Deploy " "| Deploy a KVM with iso or img file. After deploying process virt-viewer will run." \
		"Image List " "| List of image files." \
		"Clone " "| Clone an existing KVM with new settings." \
	       	"Exit " "| You are welcome." 3>&1 1>&2 2>&3)
case $menu in 
"Deploy ")
	deploy_kvm
	;;
"Image List ")
	iso_list
	;;
"Clone ")
	clone_kvm
	;;
esac
}

function iso_list(){
i=0
s=65    # decimal ASCII "A" 
for f in images/
do
    # convert to octal then ASCII character for selection tag
    files[i]=$(echo -en "\0$(( $s / 64 * 100 + $s % 64 / 8 * 10 + $s % 8 ))")
    files[i+1]="$f"    # save file name
    ((i+=2))
    ((s++))
done
	isomenu=$(whiptail --clear --title "Iso List" --menu "Choose an option" 40 100 10 "${files[@]}" 3>&1 1>&2 2>&3 )
}

function clone_kvm(){
	$(TERM=ansi whiptail --inputbox "Select vm to clone" 8 78  --title "Clonelicaz ins" 3>&1 1>&2 2>&3)
	exitstatus=$?
}

function deploy_kvm(){

KVM_NAME=$(whiptail --inputbox "Kvm Domain Name" 8 39 --title "Please enter KVM Domain Name" 3>&1 1>&2 2>&3)
exitstatus=$?

if [ $exitstatus = 0 ]
then
	echo "Kvm Name: ${KVM_NAME}"
else
	main_menu
fi

KVM_SIZE=$(whiptail --inputbox "Desired KVM Size" 8 39 --title "Please enter desired KVM Disk Size" 3>&1 1>&2 2>&3)
exitstatus=$?

if [ $exitstatus = 0 ]
then
	echo "Kvm Size: ${KVM_SIZE}"
else
	exit
fi


KVM_ISO=$(whiptail --inputbox "Full name of the iso: " 8 39 --title "Please enter the full name of iso" 3>&1 1>&2 2>&3)
exitstatus=$?

if [ $exitstatus = 0 ]
then
	echo "Test"
else
	exit
fi
#if [ $exitstatus = 0 ]
#then
#	echo "ISO: ${KVM_ISO}"
#else
#	exit
#fi


KVM_OS=$(whiptail --inputbox "Os-Variant " 8 39 --title "Please enter desired os-variant option of virt-install" 3>&1 1>&2 2>&3)
exitstatus=$?

if [ $exitstatus = 0 ]
then
	echo "Os-Variant: ${KVM_OS}"
else
	exit
fi

}

function virt-install(){

virt-install --name=${KVM_NAME} \
--vcpus=2 \
--memory=4096 \
--cdrom=/home/${USER}/Desktop/kvm/images/${KVM_ISO} \
--disk size=${KVM_SIZE} \
--os-variant=${KVM_OS}

}

main_menu
