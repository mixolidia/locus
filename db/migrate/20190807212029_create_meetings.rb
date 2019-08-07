class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coordinate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
