# Define the header line
header = "initiatorPilotName,target_coalition,linked_event_id,targetMissionID,target_ws_type1,initiator_object_id,target,target_object_id,targetPilotName,type,target_unit_type,t,initiator_unit_type,event_id,weapon,initiator_ws_type1,initiatorMissionID,initiator_coalition\n"

# Open the input text file
with open('test2_to_csv.txt', 'r') as txt_file:
    # Open the output CSV file
    with open('test2_data.csv', 'w') as csv_file:
        # Write the header line to the CSV file
        csv_file.write(header)
        
        # Iterate over each line in the input text file
        for line in txt_file:
            # Remove leading and trailing whitespace, then split by comma
            data = line.strip().split(',')
            
            # Join the data with comma and write to the CSV file
            csv_file.write(','.join(data) + '\n')

print("Conversion completed successfully.")