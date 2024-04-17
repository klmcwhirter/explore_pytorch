# explore_pytorch
Simple exploratory materials for pytorch with Linux laptop containing an NVIDIA GPU

![Fedora](https://img.shields.io/badge/Fedora-39-51A2DA?logo=Fedora)
![NVIDIA](https://img.shields.io/badge/nvidia-GeoForce%20RTX%203050%20Ti%20Mobile-76B900?logo=NVIDIA)
![Python](https://img.shields.io/python/required-version-toml?tomlFilePath=https%3A%2F%2Fraw.githubusercontent.com%2Fklmcwhirter%2Fexplore_pytorch%2Fmaster%2Fpyproject.toml&logo=Python)
![PyTorch](https://img.shields.io/badge/PyTorch-2.2-EE4C2C?logo=PyTorch)


## Overview
The purpose of this project is to capture the things needed to consider when getting started with PyTorch on Fedora Linux running on a laptop containing an NVIDIA GPU.

## Pre-requisites

### CUDA NVIDIA driver
To install the CUDA NVIDIA driver on Fedora 39 see [installation instructions](./jupyter/installing_cuda_drivers_on_fedora39.ipynb)

### Python 3.12
Fedora 39 comes with Python 3.12.2. But, to be certain ...

```
$ sudo dnf install python3.12
```

### PDM
Install `pdm`. See https://pdm-project.org/latest/#recommended-installation-method.

Then execute the following in this repo to create the virtualenv and install Python dependencies.

```
$ pdm create
```

### VS Code with Python
To install VS Code on Fedora follow these [MS instructions](https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions).

Then install the Python extensions.
[VS Code Python Quick Start](https://code.visualstudio.com/docs/python/python-quick-start)

### Test setup in VS Code
`Run All` in [jupyter/pytorch-install-jul-2020.ipynb](./jupyter/pytorch-install-jul-2020.ipynb)

### Force CPU Only
See this project for a tool to disable the GPU: [nvidia_more_battery](https://github.com/klmcwhirter/nvidia-more-battery)

Once you have nvidia_more_battery `enabled` and have rebooted run the tests again to see the difference!

## Jupyter Notebooks
* light-weight performance test [jupyter/t81_558_class_03_2_pytorch.ipynb](./jupyter/t81_558_class_03_2_pytorch.ipynb)

## References

### PyTorch
* [PyTorch docs](https://pytorch.org/docs/stable/index.html)
* [PyTorch Tutorials](https://pytorch.org/tutorials/)
* [PyTorch GitHub repo](https://github.com/pytorch/pytorch)
* [How to Install PyTorch on Linux for CPU or GPU - No Driver Install Needed - YT (~10 mins)](https://youtu.be/YTvVxYneu7w)

### NVIDIA and CUDA
* [NVIDIA CUDA in 100 Seconds](https://youtu.be/pPStdjuYzSI)
* [NVIDIA XFree86 README](http://us.download.nvidia.com/XFree86/Linux-x86_64/550.67/README/index.html)
* [Chapter 17. Using the NVIDIA Driver with Optimus Laptops](http://us.download.nvidia.com/XFree86/Linux-x86_64/550.67/README/optimus.html)
* [Chapter 35. PRIME Render Offload](http://us.download.nvidia.com/XFree86/Linux-x86_64/550.67/README/primerenderoffload.html)
* [archwiki PRIME](https://wiki.archlinux.org/title/PRIME)
* [archwiki NVIDIA](https://wiki.archlinux.org/title/NVIDIA)
* [How to Install NVIDIA Drivers on Fedora 39, 38 Linux](https://www.linuxcapable.com/how-to-install-nvidia-drivers-on-fedora-linux/)

### Professor at WSUTL
* [T81 558: Applications of Deep Neural Networks](https://github.com/jeffheaton/app_deep_learning)
* [Original T81 558:Applications of Deep Neural Networks](https://github.com/jeffheaton/t81_558_deep_learning/tree/476c4df534dea71539bdc17742b5e92a255af880/) this commit still contains some PyTorch content
