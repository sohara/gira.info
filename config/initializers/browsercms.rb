Cms.attachment_file_permission = 0640

if RAILS_ENV == 'production'
  # Uploaded files/images will be written out to this directory instead of the default (tmp/uplaods) directory
  Attachment.storage_location = File.join(Rails.root, "uploads")
end
