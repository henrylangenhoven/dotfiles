#!/bin/bash

# Check if the .build_images file exists
if [ ! -f .build_images ]; then
    echo ".build_images file not found!"
    exit 1
fi

# Repository name
repository_name="350124346922.dkr.ecr.eu-central-1.amazonaws.com/entrnce"

# Base directory for all projects
base_dir="$ENTRNCE"

# Loop through each line in the .build_images file
while IFS= read -r line; do
    # Skip empty lines or lines starting with #
    if [[ -z "$line" || "$line" =~ ^# ]]; then
        continue
    fi

    # Read the project directory name and tag from the line
    project_dir=$(echo "$line" | awk '{print $1}')
    tag=$(echo "$line" | awk '{print $2}')

    # Determine the image name (same as the project directory name)
    image_name=$project_dir

    # Determine the full path to the project directory
    folder="$base_dir/$project_dir"

    # Check if the folder exists
    if [ ! -d "$folder" ]; then
        echo "Folder $folder does not exist. Skipping..."
        continue
    fi

    # Navigate to the project directory
    cd "$folder" || exit

    # Build the project if it is an npm project
    if [ -f "package.json" ]; then
        echo "Building npm project in $folder"
        npm install
        npm run build:shared
        npm run build
        if [ $? -ne 0 ]; then
            echo "Failed to build npm project in $folder. Exiting..."
            exit 1
        fi
    # Build the project if it is a Gradle project
    elif [ -f "build.gradle" ]; then
        echo "Building Gradle project in $folder"
        ./gradlew build
        if [ $? -ne 0 ]; then
            echo "Failed to build Gradle project in $folder. Exiting..."
            exit 1
        fi
    else
        echo "No recognized build file found in $folder. Skipping build step..."
    fi

    # Build the Docker image
    docker build -t "$repository_name/$image_name:$tag" "$folder"

    # Check if the build was successful
    if [ $? -ne 0 ]; then
        echo "Failed to build image $repository_name/$image_name:$tag. Exiting..."
        exit 1
    else
        echo "Successfully built image $repository_name/$image_name:$tag"
    fi

    # Navigate back to the base directory
    cd "$base_dir" || exit
done < .build_images

echo "All images built successfully."
