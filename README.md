# Batch Images downloader for Wordpress

This script downloads images from a Wordpress site and saves them to a local directory.
You should place the xml file from the Wordpress export in the same directory as this script.
The script will parse the xml file and download all images to a local directory.

## Requirements

- Ruby 3.X
- Nokogiri gem
- OpenURI gem
- FileUtils gem

## Installation
Make sure to have `ruby 3.0.X` and higher. 
If you don't have any specific ruby versions, checkout this guide (MACOS): https://formulae.brew.sh/formula/ruby@3.0

All you need to do is run
```
bundle install
```

## Usage

1. Place the xml file from the Wordpress export in the same directory as this script.
2. Run the script with the following command:

```bash
ruby download_images.rb
```

3. Once downloaded, the images will be saved in a directory named `downloaded_images` in the same directory as the script.
4. The script will create the directory if it does not exist.

## Bonus

There is another script called `sort_images.rb` that will sort the downloaded images into subdirectories based on the extension of the image files. This is useful for organizing the images into different folders based on their file types.
To use this script, run the following command:

```bash
ruby sort_images.rb
```

This will create subdirectories for each file type and move the images into the corresponding subdirectory.
