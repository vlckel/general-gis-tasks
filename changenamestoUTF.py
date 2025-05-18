import os
import arcpy

# Define the input directory and output file geodatabase path
input_dir = r"E:\\zabaged\\zabagedFIN\\SPADOVKY"


# Mapping of Czech letters to UTF-8 equivalents
czech_to_utf = {
    "á": "a", "č": "c", "ď": "d", "é": "e", "ě": "e", "í": "i", "ň": "n",
    "ó": "o", "ř": "r", "š": "s", "ť": "t", "ú": "u", "ů": "u", "ý": "y", "ž": "z",
    "Á": "A", "Č": "C", "Ď": "D", "É": "E", "Ě": "E", "Í": "I", "Ň": "N",
    "Ó": "O", "Ř": "R", "Š": "S", "Ť": "T", "Ú": "U", "Ů": "U", "Ý": "Y", "Ž": "Z"
}

# Function to replace Czech letters in a string
def replace_czech_letters(name):
    for czech, utf in czech_to_utf.items():;
        name = name.replace(czech, utf)
    return name

# Rename shapefiles to remove Czech letters
for filename in os.listdir(input_dir):
    old_path = os.path.join(input_dir, filename)
    new_filename = replace_czech_letters(filename)
    new_path = os.path.join(input_dir, new_filename)
    if old_path != new_path:
        os.rename(old_path, new_path)
        print(f"Renamed: {old_path} -> {new_path}")

