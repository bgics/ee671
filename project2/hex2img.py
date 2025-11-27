from PIL import Image
import numpy as np

def hex_to_image(hex_string, output_path='output.png'):
    """
    Convert hex string to a 254x254 image.
    
    Args:
        hex_string: Hex string (with or without spaces/0x prefixes)
        output_path: Path to save the output image
    """
    # Clean the hex string (remove spaces, newlines, 0x prefixes)
    hex_clean = hex_string.replace(' ', '').replace('\n', '').replace('0x', '')
    
    # Convert hex to bytes
    byte_data = bytes.fromhex(hex_clean)
    
    # Take first 254*256 bytes
    total_bytes = 254 * 256
    byte_data = byte_data[:total_bytes]
    
    # Convert to numpy array
    data_array = np.frombuffer(byte_data, dtype=np.uint8)
    
    # Reshape to 254 rows x 256 columns
    image_array = data_array.reshape(254, 256)
    
    # Remove last 2 columns from each row to get 254x254
    image_array = image_array[:, :254]
    
    # Create image from array
    img = Image.fromarray(image_array, mode='L')  # 'L' for grayscale
    
    # Save image
    img.save(output_path)
    print(f"Image saved to {output_path}")
    
    return img

import argparse

# Example usage
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Convert hex file to 254x254 image')
    parser.add_argument('-i', '--input', required=True, help='Input hex file')
    parser.add_argument('-o', '--output', required=True, help='Output image file (PNG)')
    
    args = parser.parse_args()
    
    # Read hex data from file
    with open(args.input, 'r') as f:
        hex_data = f.read()
    
    # Convert and save
    img = hex_to_image(hex_data, args.output)
    
    print(f"Image dimensions: {img.size}")  # Should be (254, 254)
