rm -f ./images/thumbs/*
for file in ./images/fulls/*.{heic,HEIC,JPEG}; do
    [ -e "$file" ] || continue
    magick "$file" "${file%.*}.jpg" && rm "$file"
done
# mogrify -resize 25% -quality 100 -path ./images/thumbs ./images/fulls/*.jpg
for file in ./images/fulls/*; do
    [ -e "$file" ] || continue
    mogrify -resize 25% -quality 100 -path ./images/thumbs "$file"

    # 找到生成的缩略图路径
    thumb_file="./images/thumbs/$(basename "$file")"

    # 获取原始文件的创建时间
    original_ctime=$(stat -f "%B" "$file") # macOS
    # original_ctime=$(stat --format=%W "$file") # Linux

    # 设置缩略图文件的创建时间与原文件一致
    touch -t "$(date -r "$original_ctime" +"%Y%m%d%H%M.%S")" "$thumb_file"
done
