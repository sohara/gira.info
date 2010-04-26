class AddPhotoToMembres < ActiveRecord::Migration
  def self.up
    add_column "membres", "photo_file_name", :string
    add_column "membres", "photo_content_type", :string
    add_column "membres", "photo_file_size", :integer
    add_column "membres", "photo_updated_at", :datetime
    add_column "membre_versions", "photo_file_name", :string
    add_column "membre_versions", "photo_content_type", :string
    add_column "membre_versions", "photo_file_size", :integer
    add_column "membre_versions", "photo_updated_at", :datetime
  end

  def self.down
    remove_column "membres", "photo_file_name"
    remove_column "membres", "photo_content_type"
    remove_column "membres", "photo_file_size"
    remove_column "membres", "photo_updated_at"
    remove_column "membre_versions", "photo_file_name"
    remove_column "membre_versions", "photo_content_type"
    remove_column "membre_versions", "photo_file_size"
    remove_column "membre_versions", "photo_updated_at"
  end
end