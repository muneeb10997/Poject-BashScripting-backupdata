#!/bin/bash

# Get the folder path from the argument 
Input_Folder_Path="$1"

# Backup folder path (Update this to a valid Linux path)
Backup_Folder_Path="/home/muneeb/Desktop/bash_script_project/Backup" 

# Get the name of the folder from the input path
folder_name=$(basename "$Input_Folder_Path")


folder_dir=$(dirname "$Input_Folder_Path")

# Setting the current timestamp with a good format
date_time=$(date +"%Y-%m-%d_%H-%M-%S") 


# Check if the argument is passed
if [ "$#" -ne 1 ]; then
    echo "The path of the folder is not provided."
    exit 1 
fi

# Check if the provided path is a valid directory
if [ ! -d "$Input_Folder_Path" ]; then 
    echo "The input path $Input_Folder_Path is not a valid directory."
    exit 1 
fi

echo "Backup Folder Name : $folder_name"

# Setting the backup zip file name with timestamp
zip_file_name="${folder_name}-${date_time}.zip" 
zip_file_path="$Backup_Folder_Path/$zip_file_name"


# Remove the previous zip file if it exists
base_zip_file_name="${folder_name}*.zip"
for old_zip in "$Backup_Folder_Path"/$base_zip_file_name;
do
    if [ -f "$old_zip" ]
	then
        echo "Removing existing zip file: $old_zip"
        rm "$old_zip"
    fi
done

# Creating Zip of the folder for backup 
echo "Creating Zip of the folder: $folder_name"
(cd "$folder_dir" && zip -r "$zip_file_path" "$folder_name")

# Print success message
if [ $? -eq 0 ]; then
    echo "Backup successfully created at: $zip_file_path"
else
    echo "Failed to create backup."
fi
