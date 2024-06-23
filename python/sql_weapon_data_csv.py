import csv

def process_csv(file_path):
    sql_statements = []
    with open(file_path, mode='r') as file:
        csv_reader = csv.reader(file)
        for row in csv_reader:
            if not row or len(row[0]) == 0:
                continue  # Skip empty rows or rows with no data
            # Combine all pairs in the row into a single string
            data_string = ','.join(row[1:])

            # Split the data_string into individual key-value pairs
            pairs = data_string.split(',')
                    
            # Initialize lists for keys and values
            keys = []
            values = []
            # Process each pair
#            for pair in pairs:
#                key, value = pair.split('=')
#                keys.append(key.strip())
#                values.append(value.strip())
            for pair in pairs:
                # Check if the pair can be split into key and value
                if '=' in pair:
                    key, value = pair.split('=')
                    keys.append(key.strip())
                    values.append(value.strip())
                else:
                    continue
                    #print(f"Ignoring malformed pair: {pair}")
                # Construct the SQL INSERT statement
                #sql_insert = f"INSERT INTO YourTableName ({', '.join(keys)}) VALUES ({', '.join(['%s']*len(values))})"
            sql_insert = f"INSERT INTO Shots ({', '.join(keys)}) VALUES ({', '.join(values)})"
            print(sql_insert)
            
    
    return sql_statements

# Example usage
file_path = 'sql_weapons_test_data.csv'
#file_path = 'test2_data.csv'
sql_statements = process_csv(file_path)
for statement in sql_statements:
    print(statement)
