# find_all_keys.py
def extract_all_keys(file_path):
    all_keys = set()

    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            # Split rows separated by commas, but not full CSV rows necessarily
            parts = line.strip().split(',')
            for part in parts:
                if '=' in part:
                    key = part.split('=')[0].strip()
                    if key:
                        all_keys.add(key)
    
    return sorted(all_keys)


if __name__ == "__main__":
    file_path = "test2_data.csv"  # change this to your file path
    keys = extract_all_keys(file_path)

    print(f"Found {len(keys)} unique keys:")
    for k in keys:
        print(k)
