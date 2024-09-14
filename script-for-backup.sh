#!/bin/bash

# Get the folder path from the argument 
Input_Folder_Path="$1"

# Backup folder path 
Backup_Folder_Path="$2" 

# Get the name of the folder from the input path
folder_name=$(basename "$Input_Folder_Path")

# get the input folder path except the folder you want to backup
folder_dir=$(dirname "$Input_Folder_Path")

# Setting the current timestamp
date_time=$(date +"%Y-%m-%d_%H-%M-%S") 

# Check the Input folder path is provided or not
if [ "$#" -ne 2 ]
then
    echo "please provide both input and ouput folders paths"
    exit 1
fi


# Check if the provided path is a valid directory
if [ ! -d "$Input_Folder_Path" ]
then 
    echo "The input path $Input_Folder_Path is not a valid directory."
    exit 1 
fi


# Check if the provided path is a valid directory
if [ ! -d "$Backup_Folder_Path" ]
then 
    echo "The backup path $Backup_Folder_Path is not a valid directory."
    exit 1 
fi

echo "Backup Folder Name : $folder_name"

# Setting the backup zip file name with timestamp
zip_file_name="${folder_name}-${date_time}.zip" 
zip_file_path="$Backup_Folder_Path/$zip_file_name"

# Remove the previous zip file if it exists
base_zip_file_name="${folder_name}*.zip"
for old_zip in "$Backup_Folder_Path"/$base_zip_file_name
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

# Print success message for backup done or not
if [ $? -eq 0 ]
then
    echo "Backup successfully created at: $zip_file_path"
else
    echo "Failed to create backup."
fi
