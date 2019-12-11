class AddProviderToDogWalking < ActiveRecord::Migration[6.0]
  def change
    add_reference :dog_walkings, :provider, index: true
  end
end
