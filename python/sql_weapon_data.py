data = """
weapon_type=9243142,
initiatorPilotName=FA-18C_hornet,
target_coalition=1,
linked_event_id=1563,
targetMissionID=58,
target_ws_type1=1,
initiator_object_id=16807937,target=MiG-25PD,
target_object_id=16778497,
targetPilotName=MiG-25PD,
type=KILL,
target_unit_type=MiG-25PD,
t=2250.32,
initiator_unit_type=FA-18C_hornet,
event_id=1567,
weapon=20mm HE,
initiator_ws_type1=1,
initiatorMissionID=54,
initiator_coalition=2,
"""

# Splitting the data into key-value pairs
pairs = [pair.strip().split('=') for pair in data.strip().split(',')]

# Constructing the SQL INSERT statement
sql_insert = "INSERT INTO Shots ("
sql_values = "VALUES ("

for index, pair in enumerate(pairs):
    try:
        key = pair[0]
        value = pair[1]
        if index < len(pairs) - 1:  # Exclude the last comma
            sql_insert += key + ", "
            sql_values += "'" + value + "', "
        else:  # Last pair, exclude comma
            sql_insert += key + ") "
            sql_values += "'" + value + "')"
    except IndexError:
        continue  # Continue to the next iteration if IndexError occurs

#for pair in pairs:
#    sql_insert += pair[0] + ", "
#    sql_values += "'" + pair[1] + "', "

# Remove trailing commas and add closing parentheses
sql_insert = sql_insert[:-2] + ") "
sql_values = sql_values[:-2] + ")"

# Combine the INSERT and VALUES parts
sql_statement = sql_insert + sql_values

print(sql_statement)
