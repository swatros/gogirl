class AddJourneyToIncidents < ActiveRecord::Migration[6.0]
  def change
    add_reference :incidents, :journey, foreign_key: true, null: true
  end
end
