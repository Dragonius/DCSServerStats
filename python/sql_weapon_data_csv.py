import csv

def process_csv(file_path):
    sql_statements = []
    with open(file_path, mode='r') as file:
        csv_reader = csv.reader(file)
        for row in csv_reader:
            try:
                pairs = [pair.strip().split('=') for pair in row[0].split('=,')]
                keys = []
                values = []

                for pair in pairs:
                    if len(pair) != 2:
                        raise ValueError(f"Data mismatch in row: {row}")
                    key = pair[0]
                    value = pair[1]
                    keys.append(key)
                    values.append(f"'{value}'")

                sql_insert = "INSERT INTO Shots (" + ", ".join(keys) + ") "
                sql_values = "VALUES (" + ", ".join(values) + ")"
                
                sql_statement = sql_insert + sql_values
                sql_statements.append(sql_statement)
            except ValueError as e:
                print(e)
    
    return sql_statements

# Example usage
file_path = 'sql_weapons_test_data.csv'
sql_statements = process_csv(file_path)
for statement in sql_statements:
    print(statement)
