class RemoveNomAndAddCoordinationToMembres < ActiveRecord::Migration
  def self.up
    add_content_column :membres, :coordination, :boolean
    remove_column "membres", "nom"
    remove_column "membre_versions", "nom"  
  end

  def self.down
    add_column "membres", "nom", :string
    add_column "membre_versions", "nom", :string
  end
end
