class CreateMembres < ActiveRecord::Migration
  def self.up
    create_content_table :membres do |t|
      t.string :nom 
      t.string :nom_de_tri 
      t.string :institution 
      t.belongs_to :attachment
      t.integer :attachment_version 
      t.text :texte_fr, :size => (64.kilobytes + 1) 
      t.text :texte_en, :size => (64.kilobytes + 1) 
      t.text :texte_pt, :size => (64.kilobytes + 1) 
      t.text :texte_sp, :size => (64.kilobytes + 1) 
    end
    
    unless Section.with_path('/membres').exists?
      Section.create!(:name => "Membre", :parent => Section.system.first, :path => '/membres', :allow_groups=>:all)
    end
    ContentType.create!(:name => "Membre", :group_name => "Membre")
  end

  def self.down
    ContentType.delete_all(['name = ?', 'Membre'])
    CategoryType.all(:conditions => ['name = ?', 'Membre']).each(&:destroy)
    #If you aren't creating a versioned table, be sure to comment this out.
    drop_table :membre_versions
    drop_table :membres
  end
end
