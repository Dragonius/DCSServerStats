import csv

def generate_sql_commands(csv_file_path, table_name):
    # Read the CSV file and extract the header
    with open(csv_file_path, 'r') as csvfile:
        csvreader = csv.reader(csvfile)
        header = next(csvreader)
    
    # Generate SQL command to create table
    create_table_sql = f"CREATE TABLE IF NOT EXISTS {table_name} (\n"
    for column_name in header:
        create_table_sql += f"    {column_name} TEXT,\n"
    create_table_sql = create_table_sql.rstrip(',\n') + "\n);"
    
    # Generate SQL commands to insert data
    insert_data_sql = []
    with open(csv_file_path, 'r') as csvfile:
        csvreader = csv.DictReader(csvfile)
        for row in csvreader:
            values = ', '.join(f"'{value.replace("'", "''")}'" if "'" in value else f"'{value}'" for value in row.values())
            insert_data_sql.append(f"INSERT INTO {table_name} ({', '.join(row.keys())}) VALUES ({values});")
    
    return create_table_sql, insert_data_sql

# Example usage
csv_file_path = 'test2_data.csv'
table_name = 'my_table'

create_table_sql, insert_data_sql = generate_sql_commands(csv_file_path, table_name)

print("SQL command to create table:")
print(create_table_sql)

print("\nSQL commands to insert data:")
for sql_command in insert_data_sql:
    print(sql_command)
