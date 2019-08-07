class CreateCoordinates < ActiveRecord::Migration[6.0]
  def change
    create_table :coordinates do |t|
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
