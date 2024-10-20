'''From https://docs.cupy.dev/en/stable/reference/generated/cupy.fuse.html'''

import argparse
from datetime import datetime
from functools import wraps
from pprint import pprint

import cupy as cp
import numpy as np

# region reusable functional tools


def timed(func):
    @wraps(func)
    def decorator(*args, **kwargs):
        start = datetime.now()
        print(f'start: {start}')
        func(*args, **kwargs)
        end = datetime.now()
        print(f'end: {end}')
        print(f'elapsed time: {end - start}', end='\n\n')
    return decorator


def driver(n: int, n_iters: int, randn, diff, verbose: bool = False) -> None:
    for i in range(n_iters):
        x = randn(n)
        y = randn(n)[::-1]

        if verbose:
            print(f'{i}: ', end='')
            pprint(diff(x, y))
        else:
            diff(x, y)

# endregion reusable functional tools


def main(n: int, n_iters: int, gpu_id: int):
    # region driver definitions

    @timed
    def gpu_driver(n: int, n_iters: int, gpu_id: int = 0, verbose: bool = False) -> None:

        @cp.fuse(kernel_name='squared_diff')
        def squared_diff(x, y):
            return (x - y) * (x - y)

        with cp.cuda.Device(gpu_id) as cuda_dev:
            driver(n=n, n_iters=n_iters, randn=cp.random.randn, diff=squared_diff, verbose=verbose)

    @timed
    def cpu_driver(n: int, n_iters: int, verbose: bool = False) -> None:

        def cpu_squared_diff(x, y):
            return (x - y) * (x - y)

        driver(n=n, n_iters=n_iters, randn=np.random.randn, diff=cpu_squared_diff, verbose=verbose)

    # endregion driver definitions

    print(f'{n=:_}, {n_iters=:_}, {gpu_id=:_}', end='\n\n')

    print(f'Running on GPU as gpu_driver({n=:_}, {n_iters=:_}, {gpu_id=}) - expect <1 sec:')
    gpu_driver(n=n, n_iters=n_iters, gpu_id=gpu_id)

    print(f'Running on CPU as cpu_driver({n=:_}, {n_iters=:_}) - expect ~5 mins:')
    cpu_driver(n=n, n_iters=n_iters)


if __name__ == '__main__':
    N = 100_000_000
    N_ITERS = 100
    GPU_ID = 0

    # region parse args

    parser = argparse.ArgumentParser()
    parser.add_argument('-n', default=N, type=int, help=f'size of arrays to process (default: {N:_})')
    parser.add_argument('--n-iters', '-i', default=N_ITERS, type=int, help=f'number of iterations (default: {N_ITERS:_})')
    parser.add_argument('--gpu-id', '-g', default=GPU_ID, type=int, help=f'ID of GPU. (default: {GPU_ID})')
    args = parser.parse_args()

    # endregion parse args

    main(n=args.n, n_iters=args.n_iters, gpu_id=args.gpu_id)
