class AddDefaultDataBlog < ActiveRecord::Migration

  def self.up
    Post.create( 
    :title => 'Blogindlæg nr. 1',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er indlæg nr. 1, som handler om hvor godt det kunne være at...' )
    Post.create( 
    :title => 'Blogindlæg nr. 2',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er indlæg nr. 2, som handler om hvor godt det kunne være at...' )
    Post.create( 
    :title => 'Blogindlæg nr. 3',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er indlæg nr. 3, som handler om hvor godt det kunne være at...' )
    Post.create( 
    :title => 'Blogindlæg nr. 4',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er indlæg nr. 4, som handler om hvor godt det kunne være at...' )
    Post.create( 
    :title => 'Blogindlæg nr. 5',
    :author => 'TKS',
    :active => true,
    :user_id => 1,
    :body => 'Her er indlæg nr. 5, som handler om hvor godt det kunne være at...' )
  end

  def self.down
    ActiveRecord::Base.connection.execute('TRUNCATE posts')
  end

end