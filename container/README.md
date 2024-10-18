# cupy examples using container
These are a few of the examples from https://github.com/cupy/cupy/tree/main/examples.

A helper script [run_cupy](./run_cupy) has been provided to show how to run them
with the official cupy/cupy docker image.

Note that the actual steps are different on at least Fedora 40 than documented
by the cupy project at [LINK](https://github.com/cupy/cupy?tab=readme-ov-file#docker).

## pre-requisites for Fedora 40
I have only tested this on Fedora 40. The pre-requisites may be lighter without SELinux. YMMV.

* Install cuda-toolkit - https://copr.fedorainfracloud.org/coprs/g/ai-ml/nvidia-container-toolkit/
* use podman: The `nvidia-container-toolkit-selinux` package seems to provide support for podman but not docker.

## Run them

* start by pulling the docker.io/cupy/cupy image if not already done above. It is quite large and so this will take some time.

```bash
podman pull cupy/cupy
```

* To verify setup ...
```bash
./run_cupy ls -lah /cupy-vol/
```

* Run monte carlo simulation ...
```bash
./run_cupy examples/finance/monte_carlo.py
```

* Display GPU info
```bash
./run_cupy examples/cuda_info.py
```

## Selective Examples

* [Display CUDA and GPU info](./examples/cuda_info.py)
* [CuPy Conjugate gradient example](./examples/cg/cg.py)
* [Monte-Carlo simulation](./examples/finance/monte_carlo.py)
