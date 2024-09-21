#!/bin/bash
#*----------------------------------------------------------------------*
#*----------------------------------------------------------------------*
#* Constants
BOLD=$(tput bold)
NORM=$(tput sgr0)

#*----------------------------------------------------------------------*
#* Variables

MODE=unknown
[[ "$*" == *"u"* ]] && MODE=remove
[[ "$*" == *"i"* ]] && MODE=install
[[ "$*" == *"a"* ]] && MODE=after       # after install and reboot
echo "MODE=${MODE}"

CONFIRM=0
[[ "$*" == *"-y"* ]] && CONFIRM=1
echo "CONFIRM=${CONFIRM}"

FEDVER=$(rpm -E %fedora)

#*----------------------------------------------------------------------*
function confirm
{
    echo_bold "$*"
    read ans
    # echo ${ans}
}
#*----------------------------------------------------------------------*
function echo_bold
{
    echo '#*----------------------------------------------------------------------*'
    echo "${BOLD}$*${NORM}"
    echo '#*----------------------------------------------------------------------*'
}
#*----------------------------------------------------------------------*
function echo_exec
{
    echo_bold "$*"
    $*
    rc=$?
    if [ "${rc}" != "0" ]; then
        exit ${rc}
    fi
}
#*----------------------------------------------------------------------*
#*----------------------------------------------------------------------*


if [ ${CONFIRM} -ne 1 ]; then
    confirm 'Are you sure ?'
else
    ans="y"
fi

if [ ${ans} != "y" ]; then
    echo 'Skipping...'
else
    case ${MODE} in
        'install')
        echo_exec sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDVER}.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDVER}.noarch.rpm
        echo_exec sudo dnf -y config-manager --enable fedora-cisco-openh264
        echo_exec sudo dnf -y upgrade --refresh
        echo_exec sudo dnf -y clean all
        echo_exec sudo dnf -y makecache
        # echo_exec sudo dnf -y install kernel-headers kernel-devel tar bzip2 make automake gcc gcc-c++ pciutils elfutils-libelf-devel libglvnd-opengl libglvnd-glx libglvnd-devel acpid pkgconfig dkms

        # From
        # https://rpmfusion.org/Howto/NVIDIA#Current_GeForce.2FQuadro.2FTesla
        # https://rpmfusion.org/Howto/NVIDIA#CUDA
        # https://rpmfusion.org/Howto/NVIDIA#NVENC.2FNVDEC
        # Also see: https://rpmfusion.org/Howto/NVIDIA#Kernel_Open - not implemented here
        echo_exec sudo dnf -y install akmod-nvidia
        echo_exec sudo dnf -y install xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs

        # From https://rpmfusion.org/Howto/NVIDIA#dnf_autoremove
        echo_exec sudo dnf -y mark install akmod-nvidia

        # From https://rpmfusion.org/Howto/NVIDIA#VDPAU.2FVAAPI
        echo_exec sudo dnf -y install nvidia-vaapi-driver libva-utils vdpauinfo

        # From  https://rpmfusion.org/Howto/Multimedia#line-66
        echo_exec sudo dnf -y install libva-nvidia-driver

        # See also https://rpmfusion.org/Howto/NVIDIA#Suspend
        # echo_exec sudo dnf -y install xorg-x11-drv-nvidia-power
        # echo_exec sudo systemctl enable nvidia-{suspend,resume,hibernate}
        # Optional: tweak "nvidia options NVreg_TemporaryFilePath=/var/tmp" from /etc/modprobe.d/nvidia.conf as needed if you have issue with /tmp as tmpfs with nvidia suspend )

        sync
        ;;

        'after')
        # From
        # https://rpmfusion.org/Howto/Multimedia#line-13
        # https://rpmfusion.org/Howto/Multimedia#line-22
        echo_exec sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing
        echo_exec sudo dnf -y update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
        echo_exec sudo dnf -y update @sound-and-video

        # From https://rpmfusion.org/Howto/Multimedia#line-79
        echo_exec sudo dnf -y install rpmfusion-free-release-tainted
        echo_exec sudo dnf -y install libdvdcss

        # See https://rpmfusion.org/Howto/NVIDIA#Nouveau_compatibility
        # After reboot ...
        echo_bold Should not see any output for noveau here...
        echo_exec "lsmod | grep nouveau"
        echo_bold Done.
        ;;
    
        'remove')
        echo_exec sudo dnf -y swap ffmpeg ffmpeg-free --allowerasing

        echo_exec sudo dnf mark remove akmod-nvidia

        echo_exec sudo dnf remove libva-nvidia-driver
        echo_exec sudo dnf remove xorg-x11-drv-nvidia-cuda
        echo_exec sudo dnf remove akmod-nvidia

        echo_exec sudo grubby --update-kernel=ALL --remove-args="rd.driver.blacklist=nouveau"
        echo_exec sudo grubby --update-kernel=ALL --remove-args="modprobe.blacklist=nouveau"
        sudo sed -i 's/ rd.driver.blacklist=nouveau//;s/ modprobe.blacklist=nouveau//' /etc/default/grub
        echo_exec sleep 2
        echo_exec sudo systemctl daemon-reload
        echo_exec sudo dnf clean all
        echo_exec sudo dnf makecache
        sync
        sleep 2
        # echo_exec sudo dnf remove kernel-headers kernel-devel tar bzip2 make automake gcc gcc-c++ pciutils elfutils-libelf-devel libglvnd-opengl libglvnd-glx libglvnd-devel acpid pkgconfig dkms
        sync
        ;;

        *)
        echo "MODE unsupported: ${MODE}"
        echo "USAGE: $0 [-y] (a | i | u)"
        ;;
    esac

    echo Done
fi

#*----------------------------------------------------------------------*
