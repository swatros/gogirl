class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.string :dimension
      t.boolean :is_good
      t.float :latitude
      t.float :longitude
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
