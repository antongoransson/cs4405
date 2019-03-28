#! /bin/bash
student_id="118106310"
folders=(HW01 HW02 HW03)
for f in ${folders[@]}; do
    zip -r "$student_id-$f.zip" $f
done
