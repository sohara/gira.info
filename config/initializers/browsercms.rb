Cms.attachment_file_permission = 0640

if RAILS_ENV == 'production'
  # Uploaded files/images will be written out to this directory instead of the default (tmp/uplaods) directory
  Attachment.storage_location = File.join(Rails.root, "uploads")
end

# the following is to make browsercms play nice with Paperclip
Cms::Behaviors::Versioning::ClassMethods.class_eval do 
  def version_class_name 
    "Blah::#{name}::Version" 
  end 
end 

Cms::Behaviors::Attaching::MacroMethods.class_eval do 
  def belongs_to_attachment(options={}) 
    @belongs_to_attachment = true 
    include Cms::Behaviors::Attaching::InstanceMethods 
    before_validation :process_attachment 
    before_save :update_attachment_if_changed 
    after_save :clear_attachment_ivars 
    belongs_to :attachment, :dependent => :destroy #, :class_name => '::Attachment'
    validates_each :attachment_file do |record, attr, value| 
      if record.attachment && !record.attachment.valid? 
        record.attachment.errors.each do |err_field, err_value| 
          if err_field.to_sym == :file_path 
            record.errors.add(:attachment_file_path, err_value) 
          else 
            record.errors.add(:attachment_file, err_value) 
          end 
        end 
      end 
    end 
  end 
end

Attachment.class_eval do 
  def self.find_live_by_file_path(file_path) 
    ::Attachment.published.not_archived.first(:conditions => {:file_path => 
file_path}) 
  end
  
  def full_file_location 
    File.join(::Attachment.storage_location, file_location) 
  end 
end