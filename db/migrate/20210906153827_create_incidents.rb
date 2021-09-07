class CreateIncidents < ActiveRecord::Migration[6.0]
  def change
    create_table :incidents do |t|
      t.string :description
      t.string :crime
      t.date :date
      t.time :time
      t.string :location
      t.float :latitude
      t.float :longitude
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
