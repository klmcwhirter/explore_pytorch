from pprint import pformat

import cupy as cp


def cuda_info(cuda_dev) -> str:
    return f'''
CUDA: {cp.cuda.runtime.runtimeGetVersion()}

Device Properties ({cuda_dev.id}):
{pformat(cp.cuda.runtime.getDeviceProperties(cuda_dev.id))}
'''


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--gpu-id', '-g', default=0, type=int,
                        help='ID of GPU. (default: 0)')
    args = parser.parse_args()

    with cp.cuda.Device(args.gpu_id) as cuda_dev:
        print(cuda_info(cuda_dev))
