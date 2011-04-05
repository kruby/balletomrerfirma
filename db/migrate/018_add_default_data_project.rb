class AddDefaultDataProject < ActiveRecord::Migration

  def self.up
    Project.create( 
    :title => 'Projekt nr. 1',
    :active => true,
    :description => 'Her er projekt nr. 1, som er det nye...' )
    Project.create( 
    :title => 'Projekt nr. 2',
    :active => true,
    :description => 'Her er projekt nr. 2, som er det nye...' )
    Project.create( 
    :title => 'Projekt nr. 3',
    :active => true,
    :description => 'Her er projekt nr. 3, som er det nye...' )
  end

  def self.down
    ActiveRecord::Base.connection.execute('TRUNCATE projects')
  end

end