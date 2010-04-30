Paperclip.options[:command_path] = "/usr/local/bin"
#Paperclip.options[:magick_home] = RAILS_ENV == 'production' ? '/usr/local/lib/ImageMagick-6.3.8' : '/usr/local/lib/ImageMagick-6.3.0'
Paperclip.options[:swallow_stderr] = false
Paperclip.options[:whiny_thumbnails] = false
Paperclip.options[:log_command] = true