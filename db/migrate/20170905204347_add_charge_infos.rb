class AddChargeInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :fellows, :goal, :decimal, :precision => 8, :scale => 2, default: 75000, null: false
    add_column :contributions, :charge_id, :string
  end
end
