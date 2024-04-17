# explore_pytorch
Simple exploratory materials for pytorch with Linux laptop containing Nvidia GPU

![Fedora](https://img.shields.io/badge/Fedora-39-51A2DA?logo=Fedora)
![NVIDIA](https://img.shields.io/badge/nvidia-GeoForce%20RTX%203050%20Ti%20Mobile-76B900?logo=NVIDIA)
![Python](https://img.shields.io/python/required-version-toml?tomlFilePath=https%3A%2F%2Fraw.githubusercontent.com%2Fklmcwhirter%2Fexplore_pytorch%2Fmaster%2Fpyproject.toml&logo=Python)
![PyTorch](https://img.shields.io/badge/PyTorch-2.2-EE4C2C?logo=PyTorch)


## Overview
The purpose of this project is to capture the things needed to consider when getting started with PyTorch on Fedora Linux with a laptop containing an Nvidia GPU.

## Pre-requisites

### CUDA Nvidia driver
To install the CUDA Nvidia driver on Fedora 39 see the Method 1 section at:

[How to Install NVIDIA Drivers on Fedora 39, 38 Linux](https://www.linuxcapable.com/how-to-install-nvidia-drivers-on-fedora-linux/)

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

## Tests
TBD

## References
* [Nvidia CUDA in 100 Seconds](https://youtu.be/pPStdjuYzSI)
* [How to Install NVIDIA Drivers on Fedora 39, 38 Linux](https://www.linuxcapable.com/how-to-install-nvidia-drivers-on-fedora-linux/)
