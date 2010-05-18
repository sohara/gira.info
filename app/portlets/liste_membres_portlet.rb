class ListeMembresPortlet < Portlet

  # Mark this as 'true' to allow the portlet's template to be editable via the CMS admin UI.
  enable_template_editor true
     
  def render
    @membres = Membre.all(:order => "nom_de_tri")
  end
    
end