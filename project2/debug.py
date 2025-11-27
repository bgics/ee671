#!/usr/bin/env python3
import argparse
import numpy as np
from PIL import Image

WIDTH = HEIGHT = 254

def hex_to_int(x):
    return int(x, 16)

def main():
    parser = argparse.ArgumentParser(description="Convert hex rows/cols/pixels to a 254x254 image.")
    parser.add_argument("-i", "--input", required=True, help="Input hex file")
    parser.add_argument("-o", "--output", required=True, help="Output PNG file")
    args = parser.parse_args()

    arr = np.full((HEIGHT, WIDTH), -1, dtype=np.int32)

    with open(args.input, "r") as f:
        for line in f:
            parts = line.strip().split()
            if len(parts) != 3:
                continue

            try:
                r = hex_to_int(parts[0])
                c = hex_to_int(parts[1])
                px = hex_to_int(parts[2])
            except:
                continue

            if 0 <= r < HEIGHT and 0 <= c < WIDTH:
                if arr[r, c] == -1:
                    arr[r, c] = px
                    print(r, c, px)   # print only for first write

    # replace -1 with 0 for image
    img_arr = np.where(arr == -1, 0, arr).astype(np.uint8)
    Image.fromarray(img_arr, mode="L").save(args.output)


if __name__ == "__main__":
    main()
