# Exploring CuPy Using the Official Container and Example Programs

The CuPy [official site](https://cupy.dev/) defines the library as:
> NumPy/SciPy-compatible Array Library for GPU-accelerated Computing with Python

The main focus is on [NVIDIA GPUs by integrating with the CUDA Toolkit](https://docs.cupy.dev/en/v13.3.0/install.html#requirements),
but experimental support is available for [AMD ROCm GPUs](https://docs.cupy.dev/en/v13.3.0/install.html#using-cupy-on-amd-gpu-experimental).

> Intro video - [CuPy A NumPy compatible Library for the GPU - Sean Farley](https://youtu.be/_AKDqw6li58)

## cupy examples using container
These are a few of the examples from https://github.com/cupy/cupy/tree/main/examples.

A helper script [run_cupy](./run_cupy) has been provided to show how to run them
with the official cupy/cupy docker image.

Note that the actual steps are different on at least Fedora 40 than documented
by the cupy project at [LINK](https://github.com/cupy/cupy?tab=readme-ov-file#docker).

## bluefin-dx-nvidia:stable

This is the OS image with which I am currently using to test.

It has all the prerequisites met.

## pre-requisites for Fedora WS 40
I have tested this on Fedora WS 40 before moving to bluefin. The pre-requisites may be lighter without SELinux. YMMV.

* Install cuda-toolkit - https://copr.fedorainfracloud.org/coprs/g/ai-ml/nvidia-container-toolkit/
* use podman: The `nvidia-container-toolkit-selinux` package seems to provide support for podman but not docker.

## Run them

* start by pulling the docker.io/cupy/cupy image if not already done above. It is quite large and so this will take some time.
* I do reccomend following all the steps from the [LINK](https://copr.fedorainfracloud.org/coprs/g/ai-ml/nvidia-container-toolkit/)
above as there are some security setup and validation steps that shouild be run.

```bash
podman pull cupy/cupy
```

* To verify basic script usage ... you should see the contents of `$PWD` from inside the container.
> An error could indicate improper setup, security perms, etc.

```bash
./run_cupy ls -lah /cupy-vol/
```

* Display GPU info

> Should output information for the first GPU by default.

```bash
./run_cupy examples/cuda_info.py
```

* Run monte carlo simulation ...
```bash
./run_cupy examples/finance/monte_carlo.py
```

* Display CLI help
> Each of the scripts take command line options ...

```bash
./run_cupy examples/cuda_info.py --help
```

## Selective Examples

* [Display CUDA and GPU info](./examples/cuda_info.py)
* [CuPy Conjugate gradient example](./examples/cg/cg.py) - 100% Python program
* [Monte-Carlo simulation](./examples/finance/monte_carlo.py) - Python and a [User-Defined CUDA Kernel](https://docs.cupy.dev/en/stable/user_guide/kernel.html) in C/C++
* [Squared_diffs using @cupy.fuse](./examples/fuse/fused_squared_diffs.py)

## See Also

* [Accelerating Machine Learning on a Linux Laptop with an External GPU](https://developer.nvidia.com/blog/accelerating-machine-learning-on-a-linux-laptop-with-an-external-gpu/)
