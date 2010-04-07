class AddPageRouteForFrNewsArticles < ActiveRecord::Migration
  def self.up

    # Create Page Route to article page
    route = PageRoute.create(
      :name => "French News Article",
      :pattern => "/fr/actualites/article/:year/:month/:day/:slug",
      :code => "@news_article = NewsArticle.released_on(params).with_slug(params[:slug]).first",
      :page_id => 17)
    route.add_condition(:method, "get")
    route.add_requirement(:year, '\d{4,}')
    route.add_requirement(:month, '\d{2,}')
    route.add_requirement(:day, '\d{2,}')
    route.save!
    
  end

  def self.down
  end
end
