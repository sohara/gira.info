class AddPosteToMembres < ActiveRecord::Migration
  def self.up
    add_content_column :membres, :poste_fr, :text
    add_content_column :membres, :poste_en, :text
    add_content_column :membres, :poste_sp, :text
    add_content_column :membres, :poste_pt, :text
  end

  def self.down
    remove_colum :membres, :poste_fr
    remove_colum :membre_versions, :poste_fr
    remove_colum :membres, :poste_en
    remove_colum :membre_versions, :poste_en
    remove_colum :membres, :poste_sp
    remove_colum :membre_versions, :poste_sp
    remove_colum :membres, :poste_pt
    remove_colum :membre_versions, :poste_pt
  end
end
