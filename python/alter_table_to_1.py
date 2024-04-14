import mysql.connector

try:
# Establish connection
	connection = mysql.connector.connect(
		host="127.0.0.1",
		user="DCSServerStats2",
		password="DCSServerStats2",
		database="dcstat"
	)

	# Check if connection is successful
	if connection.is_connected():
		print("Connected to MariaDB!")


# Perform operations here...
		cursor = connection.cursor()

		# Execute SQL query to get all table names
		cursor.execute("SHOW TABLES")

		# Fetch all rows
		tables = cursor.fetchall()

		# Iterate through each row and print table names
		#for table in tables:
		#	print(table[0])  # Each table name is in the first column (index 0)
		table_list = []
		for table in tables:
			table_list.append(table[0])
		i=(len(table_list))
		i=i-1
		while i >= 0:
		# Execute SQL query to reset AUTO_INCREMENT value
			cursor.execute("ALTER TABLE " + table_list[i] +" AUTO_INCREMENT=1")
			print("Try ALTER TABLE " + table_list[i])
			i = i - 1
		# Commit the changes
		connection.commit()

	else:
		print("Failed to connect to MariaDB")

# If error, make call for it
except mysql.connector.Error as error:
	print("Error:", error)

#try:
# Create cursor
#	cursor = connection.cursor()

# Execute SQL query
#	cursor.execute("SELECT * FROM weapons")

# Fetch and print results
#	for row in cursor.fetchall():
#		print(row)

# If error, make call for it
#except mysql.connector.Error as error:
#	print("Error:", error)

finally:
	# Close cursor and connection
	if 'cursor' in locals():
		cursor.close()
	if 'connection' in locals() and connection.is_connected():
		connection.close()