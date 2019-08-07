class AddUniqueConstraints < ActiveRecord::Migration[6.0]
  def change
    add_index :addresses, :street, unique: true
      add_index :cities, :value, unique: true
      add_index :states, :value, unique: true
      add_index :users, [:first_name, :last_name, :mobile], unique: true
      add_index :coordinates, :lat, unique: true
      add_index :coordinates, :lon, unique: true
      add_index :coordinates, [:lat, :lon], unique: true
      add_index :venues, :name, unique: true
  end
end
