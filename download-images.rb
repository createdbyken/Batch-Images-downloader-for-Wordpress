# frozen_string_literal: true

require 'fileutils'
require 'nokogiri'
require 'open-uri'

# search for the XML file in the current directory
xml_file_path = Dir.glob('*.xml').first

if xml_file_path.nil?
  puts 'No XML file found in the current directory.'
  exit
end

puts "Found XML file: #{xml_file_path}"

output_directory = 'downloaded_images'

FileUtils.mkdir_p(output_directory)

def download_images_from_xml(xml_file, output_dir)
  xml_content = File.read(xml_file)
  doc = Nokogiri::XML(xml_content)

  namespace = { 'wp' => 'http://wordpress.org/export/1.2/' }

  attachment_urls = doc.xpath('//wp:attachment_url', namespace)

  if attachment_urls.empty?
    puts 'No <wp:attachment_url> tags found in the XML file.'
    return
  end

  puts "Found #{attachment_urls.size} images to download."

  attachment_urls.each_with_index do |attachment_url, idx|
    image_url = attachment_url.text
    if image_url.nil? || image_url.empty?
      puts "Skipping empty URL at index #{idx + 1}."
      next
    end

    begin
      filename = File.basename(image_url)

      output_path = File.join(output_dir, filename)

      puts "Downloading #{image_url}..."
      URI.open(image_url) do |image|
        File.open(output_path, 'wb') do |file|
          file.write(image.read)
        end
      end

      puts "Saved: #{output_path}"
    rescue OpenURI::HTTPError => e
      puts "Failed to download #{image_url}: #{e.message}"
    rescue StandardError => e
      puts "An error occurred while downloading #{image_url}: #{e.message}"
    end
  end
end

download_images_from_xml(xml_file_path, output_directory)
