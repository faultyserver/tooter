class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :handle,   limit: 32,  null: false
      t.string :password,             null: false
      t.string :name,                 null: false
      t.string :bio,      limit: 200, null: false

      t.timestamps
    end
  end
end
