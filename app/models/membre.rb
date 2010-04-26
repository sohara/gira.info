class Membre < ActiveRecord::Base
  acts_as_content_block
  
  before_validation :set_slug
  has_attached_file :photo, 
    :styles => { :col_1 => "60x120>", :col_2 => "140x280>", :col_3  => "220x440"}, 
    :url => "/uploads/:class/:attachment/:basename_:id_:style.:extension", 
    :path => ":rails_root/public/uploads/:class/:attachment/:basename_:id_:style.:extension"
  
  #validates_presence_of :name, :on => "create", :message => "must be unique"
   
  def set_slug
    self.slug = name.to_slug unless name.blank?
  end
  
  def route_params
    {:slug => slug}
  end

end
