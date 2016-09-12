class UpdateUserLengthRequirements < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :handle, :string, limit: 32
    change_column :users, :name,   :string, limit: 64
    change_column :users, :bio,    :string, limit: 200, null: true
  end
end
