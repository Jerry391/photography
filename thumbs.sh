for file in ./images/fulls/*.heic; do magick "$file" "${file%.heic}.jpg" && rm "$file"; done
for file in ./images/fulls/*.HEIC; do magick "$file" "${file%.HEIC}.jpg" && rm "$file"; done
mogrify -resize 25% -quality 100 -path ./images/thumbs ./images/fulls/*.jpg