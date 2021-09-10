class ChangeDestinationInJourneys < ActiveRecord::Migration[6.0]
  def change
    change_column :journeys, :destination_address, :string
  end
end
