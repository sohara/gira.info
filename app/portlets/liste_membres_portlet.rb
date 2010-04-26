class ListeMembresPortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor false
     
  def render
    @membres = Membre.all(:order => "nom_de_tri desc")
  end
    
end