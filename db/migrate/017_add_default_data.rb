class AddDefaultData < ActiveRecord::Migration
  
def self.up
Menu.create( :name => 'Menuer', :title => 'Menuer', :body => 'Link til Menuer', :active => 'true' )
Menu.create( :name => 'Indhold', :title => 'Indhold', :body => 'Link til Indhold', :active => 'true' )
Menu.create( :name => 'Brugere', :title => 'Brugere', :body => 'Link til Brugere', :active => 'true' )
Menu.create( :name => 'Sider', :title => 'Sider', :body => 'Link til Sider', :active => 'true' )
Menu.create( :name => 'Indlæg', :title => 'Indlæg', :body => 'Link til Indlæg', :active => 'false' )
Menu.create( :name => 'Aktiviteter', :title => 'Aktiviteter', :body => 'Link til Aktiviteter', :active => 'false' )
Menu.create( :name => 'Projekter', :title => 'Projekter', :body => 'Link til Projekter', :active => 'true' )
Menu.create( :name => 'Bloggen', :title => 'Bloggen', :body => 'Link til bloggen', :active => 'false' )
Menu.create( :name => 'Miniblog', :title => 'Miniblog', :body => 'Link til miniblog', :active => 'false' )
Menu.create( :name => 'Relationer', :title => 'Relationer', :body => 'Link til Relationer', :active => 'false' )
Menu.create( :name => 'Fotos', :title => 'Fotos', :body => 'Link til Fotos', :active => 'true' )
Menu.create( :name => 'Uploads', :title => 'Uploads', :body => 'Link til Uploads', :active => 'false' )
Menu.create( :name => 'Lister', :title => 'Lister', :body => 'Link til Lister', :active => 'false' )
Menu.create( :name => 'Parametre', :title => 'Parametre', :body => 'Link til Parametre', :active => 'true' )

Page.create( :name => 'Forside', :title => '2 raske svende og ...', :body => 'Hos os gør vi tingene lidt anderledes.', :active => 'true')
Page.create( :name => 'Om os', :title => 'Hvem er vi?', :body => 'Søren Kuskegaard startede sit firma i 2008 da krisen var på sit højeste.', :active => 'true')
Page.create( :name => 'Kontakt', :title => 'Kontakt', :body => 'Sådan kommer du i kontakt med os:', :active => 'true')
Page.create( :name => 'Projekter', :title => 'Projekter', :body => 'Her er de seneste projekter', :active => 'true')

Content.update( 1, {:controller_name => 'menus', :category => 'Admin', :position => '90', :active => 'true'})
Content.update( 2, {:controller_name => 'contents', :category => 'Admin', :position => '100', :active => 'true'})
Content.update( 3, {:controller_name => 'users', :category => 'Admin', :position => '110', :active => 'true'})
Content.update( 4, {:controller_name => 'pages', :category => 'Admin', :position => '120', :active => 'true'})
Content.update( 5, {:controller_name => 'posts', :category => 'Admin', :position => '130', :active => 'false'})
Content.update( 6, {:controller_name => 'activities', :category => 'Admin', :position => '140', :active => 'false'})
Content.update( 7, {:controller_name => 'projects', :category => 'Admin', :position => '145', :active => 'true'})
Content.update( 8, {:controller_name => 'bloggen', :category => 'User', :position => '150', :active => 'false'})
Content.update( 9, {:controller_name => 'miniblog', :category => 'User', :position => '160', :active => 'false', :parent_id => '8'})
Content.update(10, {:controller_name => 'relations', :category => 'Admin', :position => '170', :active => 'false'})
Content.update(11, {:controller_name => 'assets', :category => 'Admin', :position => '180', :active => 'true'})
Content.update(12, {:controller_name => 'uploads', :category => 'Admin', :position => '190', :active => 'false'})
Content.update(13, {:controller_name => 'lists', :category => 'Admin', :position => '200', :active => 'false'})
Content.update(14, {:controller_name => 'parameters', :category => 'Admin', :position => '210', :active => 'true'})

Content.update(15, {:controller_name => '/', :category => 'Public', :redirect => 'false', :controller_redirect => '', :action_redirect => ''})
Content.update(16, {:controller_name => 'Om os', :category => 'Public', :redirect => 'false'})
Content.update(17, {:controller_name => 'Kontakt', :category => 'Public', :redirect => 'false'})
Content.update(18, {:controller_name => 'Projekter', :category => 'Public', :redirect => 'false'})

Parameter.create( :name => 'Adgang', :value => 'Åben' )

Activity.create( :active => 'true', :title => 'Aktivitet nr. 1', :description => 'Vi går igang med taget på Bredhøjsvinget nr. 9...', :start_date => '2011-04-02 12:00', :end_date => '2011-04-03 11:00' )
Activity.create( :active => 'true', :title => 'Aktivitet nr. 2', :description => 'Vi begynder nybygningen af et hus på...', :start_date => '2011-04-03 13:00', :end_date => '2011-04-04 12:00'  )



end

def self.down
ActiveRecord::Base.connection.execute('TRUNCATE pages')
ActiveRecord::Base.connection.execute('TRUNCATE menus')
ActiveRecord::Base.connection.execute('TRUNCATE contents')
end

end