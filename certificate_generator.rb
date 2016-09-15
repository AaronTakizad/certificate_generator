#!/usr/bin/env ruby

require 'rubygems' # PREREQUISITE: > gem install rubygems; update_rubygems
require 'csv'
require 'RMagick' # PREREQUISITE: > brew install imagemagick, gem install

names = Array.new
i = 0

CSV.foreach("orders.csv") do |row|
  names[i] = (row[15].capitalize + ' ' + row[16].capitalize)
  i += 1
end

names.each do |customer_name|
  puts customer_name # for debugging
  img = Magick::Image.read('mikkie.png').first # image name
  name_overlay = Magick::Draw.new
  name_overlay.annotate(img, 1102, 1469, 551, 734, customer_name) do # image_name, textbox_width, textbox_height, x_pos, y_pos, text
    self.font = 'Helvetica' # replace with CWM font on final design
    self.pointsize = 120 # sub appropriate font size
    self.font_weight = Magick::BoldWeight # sub font weight number as integer
    self.fill = 'black' # hex colour goes here on final design
    self.align = Magick::CenterAlign
    self.gravity = Magick::CenterGravity
  end
  filename = customer_name.delete(' ').downcase
  img.write(filename + '.png')
end
