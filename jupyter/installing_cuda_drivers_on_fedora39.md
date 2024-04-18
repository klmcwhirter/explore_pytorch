# Installing NVIDIA CUDA Drivers on Fedora 39

IMPORTANT!!! DO NOT install the proprietary NVIDIA drivers from the NVIDIA website using the run script method. This will surely break your system when kernel updates appear.

See this video segment ... [Proprietary NVIDIA Drivers](https://youtu.be/CW1CLcT83as?t=419)

##### Before installing, ensure your system is updated to prevent potential conflicts between graphic card drivers and kernels. To update your Fedora system, use the following command:

```bash
sudo dnf upgrade --refresh
```

##### Import Nvidia CUDA Repository for Fedora 39:

```bash
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora39/x86_64/cuda-fedora39.repo
```

##### Proceed to install the necessary dependencies for NVIDIA Drivers:

```bash
sudo dnf install kernel-headers kernel-devel tar bzip2 make automake gcc gcc-c++ pciutils elfutils-libelf-devel libglvnd-opengl libglvnd-glx libglvnd-devel acpid pkgconfig dkms
```

##### To view the NVIDIA RPM modules, execute:

```bash
sudo dnf module list nvidia-driver
```

```
$ sudo dnf module list nvidia-driver
Last metadata expiration check: 2:42:46 ago on Wed 17 Apr 2024 07:11:24 AM PDT.
cuda-fedora39-x86_64
Name                   Stream                      Profiles                           Summary                                       
nvidia-driver          latest                      default [d], fm, ks, src           Nvidia driver for latest branch               
nvidia-driver          latest-dkms [d][e]          default [d] [i], fm, ks            Nvidia driver for latest-dkms branch          
nvidia-driver          open-dkms                   default [d], fm, ks, src           Nvidia driver for open-dkms branch            
nvidia-driver          550                         default [d], fm, ks, src           Nvidia driver for 550 branch                  
nvidia-driver          550-dkms                    default [d], fm, ks                Nvidia driver for 550-dkms branch             
nvidia-driver          550-open                    default [d], fm, ks, src           Nvidia driver for 550-open branch             

Hint: [d]efault, [e]nabled, [x]disabled, [i]nstalled
```

Select the appropriate one corresponding to your Fedora version to integrate the CUDA repository into your Fedora system.

##### To install the latest NVIDIA drivers using the DKMS method, execute:

```bash
sudo dnf module install nvidia-driver:latest-dkms
```
