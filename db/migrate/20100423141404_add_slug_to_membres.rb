class AddSlugToMembres < ActiveRecord::Migration
  def self.up
    add_content_column :membres, :slug, :string
  end

  def self.down
    remove_column :membres, :slug
    remove_column :membre_versions, :slug
  end
end
