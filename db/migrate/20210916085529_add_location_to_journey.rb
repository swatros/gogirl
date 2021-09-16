class AddLocationToJourney < ActiveRecord::Migration[6.0]
  def change
    add_column :journeys, :current_location, :jsonb
  end
end
