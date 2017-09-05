class AddCustomerId < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :customer_id, :string
    add_column :contributions, :customer_id, :string
  end
end
