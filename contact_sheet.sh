# Delete previous contact sheet
if [ -r contactsheet.JPG ]; then
  rm contactsheet.JPG
fi

i=0
row=0
columns=12

for filename in WeekInReview*.JPG; do
  convert "${filename}" -resize 268x140 "268_${filename}"
  convert "268_${filename}" -background Khaki label:"${filename}" -gravity Center -append "anno_${filename}"
  rm "268_${filename}"
  ((i+=1))
  if [ $((i % ${columns})) -eq 1 ]; then
    ((row+=1))
    cp "anno_${filename}" "row${row}.JPG" 
  else
    convert "row${row}.JPG" "anno_${filename}" +append "row${row}.JPG"
    if [ $((i % ${columns})) -eq 0 ]; then
      if [ -r contactsheet.JPG ]; then
        convert contactsheet.JPG "row${row}.JPG" -append contactsheet.JPG
      else
        cp "row${row}.JPG" contactsheet.JPG
      fi
      rm "row${row}.JPG"
    fi
  fi 
  rm "anno_${filename}"
done

