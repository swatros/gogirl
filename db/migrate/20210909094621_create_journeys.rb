class CreateJourneys < ActiveRecord::Migration[6.0]
  def change
    create_table :journeys do |t|
      t.string :origin_address
      t.integer :destination_address
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
