# Install hook code here
puts "Installing SWFUpload ...."
['javascripts', 'swfs'].each {|d|
  src_d = File.join(File.dirname(__FILE__), d)
  dest_d = File.join(RAILS_ROOT, "public")
  FileUtils.cp_r(src_d, dest_d)
}
puts "SWFUpload installation complete."
