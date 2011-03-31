class AddDefaultDataBlog < ActiveRecord::Migration

  def self.up
    Post.create( 
    :title => 'Projekt nr. 1',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er projekt nr. 1, som er det nye...' )
    Post.create( 
    :title => 'Projekt nr. 2',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er projekt nr. 2, som er det nye...' )
    Post.create( 
    :title => 'Projekt nr. 3',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er projekt nr. 3, som er det nye...' )
    Post.create( 
    :title => 'Projekt nr. 4',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er projekt nr. 4, som er det nye...' )
    Post.create( 
    :title => 'Projekt nr. 5',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er projekt nr. 5, som er det nye...' )
  end

  def self.down
    ActiveRecord::Base.connection.execute('TRUNCATE posts')
  end

end