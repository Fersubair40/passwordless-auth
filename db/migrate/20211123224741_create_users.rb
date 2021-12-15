class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :login_token
      t.datetime :login_token_verified_at

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
