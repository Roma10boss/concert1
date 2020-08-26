class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
        #add_collumn :users, :password_digest, :string
    end
  end
end
