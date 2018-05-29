#!/bin/bash

# Scale and crop all images

function scale_and_crop {
  for filename in *.JPG; do
    convert "${filename}" -resize 1080x1080 1080_resize_"${filename}.PNG"
    smartcrop --width 1080 --height 1080 1080_resize_"${filename}.PNG" 1080_crop_"${filename}.PNG"
    rm 1080_resize_"${filename}.PNG"
    convert 1080_crop_"${filename}.PNG" -resize 540x540 540_crop_"${filename}.PNG"
  done
}

function rm_scaled_and_cropped {
  for filename in 540_crop_*.PNG; do
    rm "${filename}"
  done
  for filename in 1080_crop_*.PNG; do
    rm "${filename}"
  done
}

perm() {
  local items="$1"
  local out="$2"
  local i
  [[ "$items" == "" ]] && ARRAY+=("$out") && return
  for (( i=0; i<${#items}; i++ )) ; do
    perm "${items:0:i}${items:i+1}" "$out${items:i:1}"
  done
}

# Create all 120 permutations of 5 images
function create_permutations {
  ARRAY=()

  i=1
  for filename in 540_crop_*.PNG; do
    files_540[i]="${filename}"
    ((i+=1))
  done

  i=1
  for filename in 1080_crop_*.PNG; do
    files_1080[i]="${filename}"
    ((i+=1))
  done

  perm "12345"
  for permutation in ${ARRAY[*]}; do
    if [ ! -r "vert${permutation:0:1}${permutation:1:1}.PNG" ]; then
      convert ${files_540[${permutation:0:1}]} \
              ${files_540[${permutation:1:1}]} \
              -append "vert${permutation:0:1}${permutation:1:1}.PNG"
    fi
    if [ ! -r "vert${permutation:3:1}${permutation:4:1}.PNG" ]; then
      convert ${files_540[${permutation:3:1}]} \
              ${files_540[${permutation:4:1}]} \
              -append "vert${permutation:3:1}${permutation:4:1}.PNG"
    fi
    convert "vert${permutation:0:1}${permutation:1:1}.PNG" \
            ${files_1080[${permutation:2:1}]} \
            "vert${permutation:3:1}${permutation:4:1}.PNG" \
            +append WeekInReview${permutation}.JPG
  done

  for permutation in ${ARRAY[*]}; do
    if [ -r "vert${permutation:0:1}${permutation:1:1}.PNG" ]; then
      rm "vert${permutation:0:1}${permutation:1:1}.PNG"
    fi
  done
}

# Scale/crop images to 540x540 and 1080x1080
scale_and_crop

# Create all 120 permutations of the 5 square images
create_permutations

# Clean up the temporary files
rm_scaled_and_cropped
