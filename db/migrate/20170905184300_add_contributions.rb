class AddContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :contributions do |t|
      t.decimal :amount, :precision => 8, :scale => 2
    end

    add_reference :contributions, :fellow, foriegn_key: true
    add_reference :contributions, :user, foriegn_key: true

    add_foreign_key :contributions, :fellows
    add_foreign_key :contributions, :users
  end
end
