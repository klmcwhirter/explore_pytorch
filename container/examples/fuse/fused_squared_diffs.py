'''From https://docs.cupy.dev/en/stable/reference/generated/cupy.fuse.html'''

import argparse
from datetime import datetime
from functools import wraps
from pprint import pprint

import cupy as cp
import numpy as np


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


@cp.fuse(kernel_name='squared_diff')
def squared_diff(x, y):
    return (x - y) * (x - y)


@timed
def gpu_driver(n: int, n_iters: int, verbose: bool = False) -> None:
    for i in range(n_iters):
        x = cp.random.randn(n)
        y = cp.random.randn(n)[::-1]

        if verbose:
            print(f'{i}: ', end='')
            pprint(squared_diff(x, y))
        else:
            squared_diff(x, y)


def cpu_squared_diff(x, y):
    return (x - y) * (x - y)


@timed
def cpu_driver(n: int, n_iters: int, verbose: bool = False) -> None:
    for i in range(n_iters):
        x = np.random.randn(n)
        y = np.random.randn(n)[::-1]

        if verbose:
            print(f'{i}: ', end='')
            pprint(squared_diff(x, y))
        else:
            cpu_squared_diff(x, y)


if __name__ == '__main__':
    N = 100_000_000
    N_ITERS = 100

    parser = argparse.ArgumentParser()
    parser.add_argument('-n', default=N, type=int, help=f'size of arrays to process (default: {N:_})')
    parser.add_argument('--n-iters', '-i', default=N_ITERS, type=int, help=f'number of iterations (default: {N_ITERS:_})')
    parser.add_argument('--gpu-id', '-g', default=0, type=int, help='ID of GPU. (default: 0)')
    args = parser.parse_args()

    print(f'n={args.n:_}, n_iters={args.n_iters:_}', end='\n\n')

    print(f'Running on CPU as cpu_driver(n={args.n:_}, n_iters={args.n_iters:_}) - expect ~5 mins:')
    cpu_driver(n=args.n, n_iters=args.n_iters)

    print(f'Running on GPU as gpu_driver(n={args.n:_}, n_iters={args.n_iters:_}) - expect <1 sec:')
    gpu_driver(n=args.n, n_iters=args.n_iters)
