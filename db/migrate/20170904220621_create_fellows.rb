class CreateFellows < ActiveRecord::Migration[5.1]
  def change
    create_table :fellows do |t|
      t.string :login
      t.string :name
      t.string :avatar_url
      t.text   :bio
      t.string :html_url

      t.timestamps
    end

    add_reference :fellows, :user, foreign_key: { to_table: :users }
  end
end
