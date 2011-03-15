class AddDefaultData < ActiveRecord::Migration
  
def self.up
Menu.create( :name => 'Menus', :title => 'Menus', :body => 'Link til Menus', :active => 'true' )
Menu.create( :name => 'Contents', :title => 'Contents', :body => 'Link til Contents', :active => 'true' )
Menu.create( :name => 'Users', :title => 'Users', :body => 'Link til Users', :active => 'true' )
Menu.create( :name => 'Pages', :title => 'Pages', :body => 'Link til Pages', :active => 'true' )
Menu.create( :name => 'Posts', :title => 'Posts', :body => 'Link til Posts', :active => 'true' )
Menu.create( :name => 'Activities', :title => 'Activities', :body => 'Link til Activities', :active => 'true' )
Menu.create( :name => 'Events', :title => 'Events', :body => 'Link til Events', :active => 'true' )
Menu.create( :name => 'Bloggen', :title => 'Bloggen', :body => 'Link til bloggen', :active => 'true' )
Menu.create( :name => 'Miniblog', :title => 'Miniblog', :body => 'Link til miniblog', :active => 'true' )
Menu.create( :name => 'Relations', :title => 'Relations', :body => 'Link til Relationer', :active => 'true' )
Menu.create( :name => 'Assets', :title => 'Assets', :body => 'Link til Assets', :active => 'true' )
Menu.create( :name => 'Uploads', :title => 'Uploads', :body => 'Link til Uploads', :active => 'true' )
Menu.create( :name => 'Lists', :title => 'Lists', :body => 'Link til Lists', :active => 'true' )
Menu.create( :name => 'Parameters', :title => 'Parameters', :body => 'Link til Parameters', :active => 'true' )

Page.create( :name => 'Forside', :title => 'Forside', :body => 'Forsiden med fotos', :active => 'true')
Page.create( :name => 'Blog', :title => 'Blog', :body => 'Bloggen på forsiden', :active => 'true')
Page.create( :name => 'Info', :title => 'Info', :body => 'Info om Morten Madsen', :active => 'false')
Page.create( :name => 'Fotos', :title => 'Fotos', :body => 'Fotos fra Mortens golf hverdag', :active => 'false')
Page.create( :name => 'Sponsorer', :title => 'Sponsorer', :body => 'Info om sponsorerne', :active => 'false')
Page.create( :name => 'Kontakt', :title => 'Kontakt', :body => 'Sådan kommer du i kontakt med med Morten Madsen', :active => 'false')
Page.create( :name => 'Resultater', :title => 'Resultater', :body => 'Her er mine seneste golf resultater', :active => 'false')

Content.update( 1, {:controller_name => 'menus', :category => 'Admin', :position => '90', :active => 'true'})
Content.update( 2, {:controller_name => 'contents', :category => 'Admin', :position => '100', :active => 'true'})
Content.update( 3, {:controller_name => 'users', :category => 'Admin', :position => '110', :active => 'true'})
Content.update( 4, {:controller_name => 'pages', :category => 'Admin', :position => '120', :active => 'true'})
Content.update( 5, {:controller_name => 'posts', :category => 'Admin', :position => '130', :active => 'true'})
Content.update( 6, {:controller_name => 'activities', :category => 'Admin', :position => '140', :active => 'true'})
Content.update( 7, {:controller_name => 'events', :category => 'Admin', :position => '145', :active => 'true'})
Content.update( 8, {:controller_name => 'bloggen', :category => 'User', :position => '150', :active => 'true'})
Content.update( 9, {:controller_name => 'miniblog', :category => 'User', :position => '160', :active => 'true', :parent_id => '8'})
Content.update(10, {:controller_name => 'relations', :category => 'Admin', :position => '170', :active => 'true'})
Content.update(11, {:controller_name => 'assets', :category => 'Admin', :position => '180', :active => 'true'})
Content.update(12, {:controller_name => 'uploads', :category => 'Admin', :position => '190', :active => 'true'})
Content.update(13, {:controller_name => 'lists', :category => 'Admin', :position => '200', :active => 'true'})
Content.update(14, {:controller_name => 'parameters', :category => 'Admin', :position => '210', :active => 'true'})

Content.update(15, {:controller_name => '/', :category => 'Public', :redirect => 'false', :controller_redirect => '', :action_redirect => ''})
Content.update(16, {:controller_name => 'blog', :category => 'Public', :redirect => 'false'})

Parameter.create( :name => 'Adgang', :value => 'Åben' )
Parameter.create( :name => 'Whereabouts', :value => 'Silkeborg, Denmark' )
Parameter.create( :name => 'Youtube', :value => 'http://www.youtube.com/madsengolf' )
Parameter.create( :name => 'Twitter', :value => 'http://www.twitter.com/madsengolf' )
Parameter.create( :name => 'Facebook', :value => 'http://www.facebook.com/pages/Madsengolf/166800110038294' )

Activity.create( :active => 'true', :title => 'Aktivitet nr. 1', :description => 'Skal deltage i turneringen, der betyder at...', :start_date => '2011-04-02 12:00', :end_date => '2011-04-03 11:00' )
Activity.create( :active => 'true', :title => 'Aktivitet nr. 2', :description => 'Skal deltage i turneringen, der betyder at...', :start_date => '2011-04-03 13:00', :end_date => '2011-04-04 12:00'  )
Activity.create( :active => 'true', :title => 'Aktivitet nr. 3', :description => 'Skal deltage i turneringen, der betyder at...', :start_date => '2011-04-04 14:00', :end_date => '2011-04-05 13:00'  )
Activity.create( :active => 'true', :title => 'Aktivitet nr. 4', :description => 'Skal deltage i turneringen, der betyder at...', :start_date => '2011-04-05 15:00', :end_date => '2011-04-06 14:00'  )
Activity.create( :active => 'true', :title => 'Aktivitet nr. 5', :description => 'Skal deltage i turneringen, der betyder at...', :start_date => '2011-04-06 16:00', :end_date => '2011-04-07 15:00'  )

# Content.update(15, {:controller_name => 'pages', :category => 'Public', :position => '2'})
# Content.update(16, {:controller_name => 'pages', :category => 'Public', :position => '3'})
# Content.update(17, {:controller_name => 'pages', :category => 'Public', :position => '4'})
# Content.update(18, {:controller_name => 'pages', :category => 'Public', :position => '4'})


end

def self.down
ActiveRecord::Base.connection.execute('TRUNCATE pages')
ActiveRecord::Base.connection.execute('TRUNCATE menus')
ActiveRecord::Base.connection.execute('TRUNCATE contents')
end

end