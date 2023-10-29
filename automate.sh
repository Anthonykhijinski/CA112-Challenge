#!/bin/bash

# Define paths
source_dir="/users/student/khijina2/CA112_labs/shell_images_png"
jpg_dir="/users/student/khijina2/CA112_labs/shell_images_jpg"
sharpened_dir="/users/student/khijina2/CA112_labs/shell_images_sharpened"
edged_dir="/users/student/khijina2/CA112_labs/shell_images_edged"

png2jpeg_dir="/users/student/khijina2/CA112_labs/png2jpeg"
img_filters_dir="/users/student/khijina2/CA112_labs/CA112_img_filters"

# Compile the C++ program
step1() {
    cd "$png2jpeg_dir"
    g++ -o png_to_jpg convert_png2jpg.cpp
}

# Convert PNG to JPG
step2() {
    cd "$source_dir"
    for file in *.png; do
        file_replace="${file%.png}.jpg"
        "$png2jpeg_dir/png_to_jpg" "$file" "$jpg_dir/$file_replace"
    done
}

# Sharpen images
step3() {
    cd "$jpg_dir"
    for file in *.jpg; do
        file_replace2="${file%.jpg}_SHARPENED.jpg"
        python3 "$img_filters_dir/sharp.py" "$file" "$sharpened_dir/$file_replace2"
    done
}

# Edge detection
step4() {
    cd "$sharpened_dir"
    for file in *_SHARPENED.jpg; do
        file_replace3="${file%_SHARPENED.jpg}_EDGED.jpg"
        python3 "$img_filters_dir/edge_detection.py" "$file" "$edged_dir/$file_replace3"
    done
}

# Main program
step1
step2
step3
step4

echo "Image Processing Complete"
