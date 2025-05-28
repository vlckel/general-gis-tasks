import os
import shutil

# Root directory
root_dir = r"D:\\CZECHIA\\MOSAICS"

# Walk through all subdirectories
for subdir, dirs, files in os.walk(root_dir):
    # Skip the root directory itself
    if subdir == root_dir:
        continue
    for file in files:
        if file.lower().endswith(('.tif', '.lasd')):
            src = os.path.join(subdir, file)
            dst = os.path.join(root_dir, file)
            # If destination file exists, rename source to avoid overwrite
            if os.path.exists(dst):
                base, ext = os.path.splitext(file)
                counter = 1
                while os.path.exists(dst):
                    dst = os.path.join(root_dir, f"{base}_{counter}{ext}")
                    counter += 1
            print(f"Moving: {src} -> {dst}")
            shutil.move(src, dst)