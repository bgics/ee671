import numpy as np
from PIL import Image

WIDTH = HEIGHT = 254

def hex_to_int(x):
    return int(x, 16)

def main():
    input_file = "../output.hex"
    output_file = "../output.png"

    arr = np.full((HEIGHT, WIDTH), -1, dtype=np.int32)

    with open(input_file, "r") as f:
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

    img_arr = np.where(arr == -1, 0, arr).astype(np.uint8)

    Image.fromarray(img_arr).save(output_file)

if __name__ == "__main__":
    main()
