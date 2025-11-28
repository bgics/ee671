import argparse
from PIL import Image
import numpy as np

SOBEL_GX = np.array([[-1, 0, 1],
                     [-2, 0, 2],
                     [-1, 0, 1]], dtype=int)

SOBEL_GY = np.array([[ 1,  2,  1],
                     [ 0,  0,  0],
                     [-1, -2, -1]], dtype=int)


def load_gray(path):
    return np.array(Image.open(path).convert("L"), dtype=int)


def sobel_pixel(arr, x, y, threshold):
    h, w = arr.shape

    # x,y are 0-based → border check adjusts accordingly
    if not (1 <= x <= w - 2 and 1 <= y <= h - 2):
        raise ValueError("x,y cannot be border pixels (0-based indexing).")

    # 3x3 region centered at (x,y)
    window = arr[y-1:y+2, x-1:x+2]

    gx = int(np.sum(window * SOBEL_GX))
    gy = int(np.sum(window * SOBEL_GY))
    mag = abs(gx) + abs(gy)
    edge = 255 if mag > threshold else 0

    return gx, gy, mag, edge


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--input", required=True)
    ap.add_argument("-x", type=int, required=True)
    ap.add_argument("-y", type=int, required=True)
    ap.add_argument("-t", "--threshold", type=int, required=True)
    args = ap.parse_args()

    arr = load_gray(args.input)
    gx, gy, mag, edge = sobel_pixel(arr, args.x, args.y, args.threshold)

    print(f"gx = {gx}")
    print(f"gy = {gy}")
    print(f"magnitude = {mag}")
    print(f"edge = {edge}")


if __name__ == "__main__":
    main()
