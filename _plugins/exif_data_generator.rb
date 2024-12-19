require 'exifr/jpeg'

module Jekyll
  class ImageMetadataGenerator < Generator
    priority :low

    def generate(site)
      site.static_files.each do |file|
        next unless file.extname.downcase == '.jpg' # 仅处理 JPG 文件

        # 提取文件的完整路径
        file_path = file.path

        # 提取 EXIF 数据
        exif_data = EXIFR::JPEG.new(file_path)

        if exif_data&.date_time_original
          file.data['created_time'] = exif_data.date_time_original
        else
          file.data['created_time'] = File.ctime(file_path) # 如果没有 EXIF 数据，则使用文件创建时间
        end
      end
    end
  end
end
