# frozen_string_literal: true

require 'fileutils'

png_directory = 'png_images'
jpg_directory = 'jpg_images'

FileUtils.mkdir_p(png_directory) unless Dir.exist?(png_directory)
FileUtils.mkdir_p(jpg_directory) unless Dir.exist?(jpg_directory)

Dir.glob('downloaded_images/*').each do |file|
  if File.extname(file).downcase == '.png'

    FileUtils.mv(file, File.join(png_directory, File.basename(file)))
  elsif File.extname(file).downcase == '.jpg' || File.extname(file).downcase == '.jpeg'
    FileUtils.mv(file, File.join(jpg_directory, File.basename(file)))
  end
end

puts "Images sorted into #{png_directory} and #{jpg_directory} directories."
