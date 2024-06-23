import csv

def process_csv(file_path):
    with open(file_path, mode='r') as file:
        csv_reader = csv.reader(file)
        for row in csv_reader:
            for line in row:
                pairs = line.split('=')
                print(pairs)
                #formatted_output = ",".join(pairs)
                #print(formatted_output)
                #print("\n")  # Add a newline to separate each line's output

# Example usage
file_path = 'sql_weapons_test_data.csv'
process_csv(file_path)


