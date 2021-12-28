#!/bin/bash

: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
function main_menu(){
	menu=$(whiptail --clear --title "    Virsh-Cli    " --menu "Choose an option" 40 150 10 \
		"Deploy " "| Deploy a KVM with iso or img file. After deploying process virt-viewer will run." \
		"Kvm List " "| List of installed kernel virtual machines." \
		"Manage Machines " "| Configure settings of installed kernel virtual machines." \
	  "Exit " "| Close cli" 3>&1 1>&2 2>&3)
case $menu in
"Deploy ")
	deploy_kvm
	;;
"Kvm List ")
	kvm_list
	;;
"Manage Machines ")
	kvm_list
	;;
 "Exit ")
 clear
 exit
 ;;
esac
}

function kvm_list(){
	GET_KVM_NAMES=$(for NAME in $(ls /etc/libvirt/qemu | grep xml)
do
	#((LISTNUMBER=LISTNUMBER+1)) # Damn that menu
	echo "${NAME%????} ${NAME%????}" # %???? deletes last 4 character of the string. Which is '.xml'
done)

kvmmenusu=$(whiptail --clear --title "Test" --menu "Sec" 40 150 10 \
	$GET_KVM_NAMES 3>&1 1>&2 2>&3)
	exitstatus=$?
	echo $kvmmenusu
}

function deploy(){

virt-install --name=${KVM_NAME} \
--vcpus=2 \
--memory=4096 \
--cdrom=/home/${USER}/Desktop/virt-create-cli/images/${f} \
--disk size=${KVM_SIZE} \
--os-variant=${KVM_OS}
}

function iso_list(){
i=0
s=65    # decimal ASCII "A"
for f in $(ls images/)
do
    # convert to octal then ASCII character for selection tag
    files[i]=$(echo -en "\0$(( $s / 64 * 100 + $s % 64 / 8 * 10 + $s % 8 ))")
    files[i+1]="$f"    # save file name
    ((i+=2))
    ((s++))
done
	isomenu=$(whiptail --clear --title "Iso List" --menu "Choose an option" 40 100 10 "${files[@]}" 3>&1 1>&2 2>&3)
	isomenu=$f
	echo $isomenu;
}

function manage_kvm(){
	echo "Manage Menu will be here"
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
		main_menu
fi

iso_list

KVM_OS=$(whiptail --inputbox "Os-Variant " 8 39 --title "Please enter desired os-variant option of virt-install" 3>&1 1>&2 2>&3)
exitstatus=$?

if [ $exitstatus = 0 ]
then
	echo "Os-Variant: ${KVM_OS}"
else
	main_menu
fi
deploy
}
main_menu
