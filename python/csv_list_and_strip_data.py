# find_unique_structures.py
def extract_unique_structures(file_path):
    unique_structures = set()

    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue

            # Split into key=value pairs
            parts = line.split(',')
            keys = []
            for part in parts:
                if '=' in part:
                    key = part.split('=')[0].strip()
                    if key:
                        keys.append(key)
                elif part.strip():  # catch malformed data
                    keys.append(part.strip())

            # Turn into a tuple to make it hashable for a set
            structure = tuple(keys)
            unique_structures.add(structure)

    return unique_structures


if __name__ == "__main__":
    file_path = "test2_data.csv"  # change this to your file path
    structures = extract_unique_structures(file_path)

    print(f"Found {len(structures)} unique variable patterns:\n")
    for i, structure in enumerate(structures, 1):
        print(f"" + ",".join(structure) + ",")
