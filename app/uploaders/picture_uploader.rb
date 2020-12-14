class PictureUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # 下記はデフォルトの画像保存先(保存先ディレクトリは上書き可能)
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #リサイズ、画像形式を変更に必要
  include CarrierWave::MiniMagick
 
  #上限変更
  process :resize_to_limit => [100, 100]

  #JPGで保存
  process :convert => 'jpg'

  #サムネイルを生成
  version :thumb do
    process :resize_to_limit => [300, 300]
  end

  # アップロードできる拡張子を限定(jpg,jpeg,gif,pngのみ)
  def extension_white_list
      %w(jpg jpeg gif png)
    end

  #ファイル名を変更し拡張子を同じにする
    def filename
      super.chomp(File.extname(super)) + '.jpg' 
    end

  #日付で保存
    def filename
      if original_filename.present?
        time = Time.now
        name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
        name.downcase
      end
    end
    
end
