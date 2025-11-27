#!/usr/bin/env python3
"""
hex_to_png.py

Convert DUT ASCII hex output (row col pixel) into a 254x254 PNG image.

Input file format (ASCII text, one entry per line, comments allowed):
  RR CC PP
where RR = row in hex (expected 0x01..0xFE), CC = col in hex, PP = pixel value in hex.

Behavior:
 - Maps DUT coordinates 1..254 -> image indices 0..253.
 - Prints "row=<row_idx> col=<col_idx> pix=<PIXHEX>" the first time each (row_idx,col_idx) is encountered.
 - Ignores duplicate entries for the same (row,col).
 - Saves 254x254 PNG (missing pixels remain 0).
"""

import argparse
import sys
import numpy as np
from PIL import Image

def parse_hex_byte(tok):
    tok = tok.strip()
    if tok == '':
        raise ValueError("empty token")
    return int(tok, 16)

def load_hex_file_and_build_image(path, expected_rows=254, expected_cols=254, verbose_print=True):
    img = np.zeros((expected_rows, expected_cols), dtype=np.uint8)
    processed = set()
    count = 0
    bad_lines = 0

    try:
        f = open(path, 'r')
    except FileNotFoundError:
        raise

    with f:
        for lineno, line in enumerate(f, start=1):
            raw = line.strip()
            if not raw:
                continue

            # strip inline comments starting with '#' or '//'
            for sep in ('#', '//'):
                if sep in raw:
                    raw = raw.split(sep,1)[0].strip()
            if not raw:
                continue

            parts = raw.split()
            if len(parts) < 3:
                bad_lines += 1
                continue

            try:
                r_hex = parts[0]
                c_hex = parts[1]
                p_hex = parts[2]
                r = parse_hex_byte(r_hex)
                c = parse_hex_byte(c_hex)
                p = parse_hex_byte(p_hex)
            except Exception:
                bad_lines += 1
                continue

            # Map DUT coords (1..254) to indices (0..253)
            row_idx = r - 1
            col_idx = c - 1

            if not (0 <= row_idx < expected_rows and 0 <= col_idx < expected_cols and 0 <= p <= 0xFF):
                bad_lines += 1
                continue

            key = (row_idx, col_idx)
            if key in processed:
                # Duplicate, ignore silently
                continue

            # First time we see this pixel: print and store
            processed.add(key)
            img[row_idx, col_idx] = p
            count += 1
            if verbose_print:
                # Print row/col as zero-based indices and pixel in 2-digit hex
                print(f"row={row_idx} col={col_idx} pix={p:02X}")

    return img, count, bad_lines

def save_png(img_array, out_path):
    im = Image.fromarray(img_array, mode='L')  # 8-bit grayscale
    im.save(out_path)

def main():
    parser = argparse.ArgumentParser(description="Convert DUT hex output (row col pixel) to 254x254 PNG")
    parser.add_argument('-i', '--input', required=True, help='Input hex file (e.g. output_pixels.hex)')
    parser.add_argument('-o', '--output', required=True, help='Output PNG filename (e.g. sobel.png)')
    parser.add_argument('--rows', type=int, default=254, help='Output rows (default 254)')
    parser.add_argument('--cols', type=int, default=254, help='Output cols (default 254)')
    parser.add_argument('--no-print', action='store_true', help='Do not print each first-seen pixel to stdout')
    args = parser.parse_args()

    try:
        img, count, bad = load_hex_file_and_build_image(
            args.input,
            expected_rows=args.rows,
            expected_cols=args.cols,
            verbose_print=not args.no_print
        )
    except FileNotFoundError:
        print(f"Error: input file '{args.input}' not found.", file=sys.stderr)
        sys.exit(2)
    except Exception as e:
        print("Error while reading input file:", e, file=sys.stderr)
        sys.exit(3)

    save_png(img, args.output)
    print(f"\nSaved PNG: {args.output}")
    print(f"Filled pixels (unique coordinates): {count}")
    print(f"Ignored / bad lines: {bad}")

if __name__ == "__main__":
    main()
