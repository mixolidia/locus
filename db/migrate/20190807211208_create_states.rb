class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.string :value, limit: 2

      t.timestamps
    end
  end
end
