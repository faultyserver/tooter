class ChangeEventUserToInitiator < ActiveRecord::Migration[5.0]
  def up
    rename_column :events, :user_id, :initiator_id
    add_column :events, :initiator_type, :string, null: false, default: 'User'
    Event.update_all(initiator_type: 'User')
  end

  def down
    Event.where.not(initiator_type: 'User').delete_all
    rename_column :events, :initiator_id, :user_id
    remove_column :events, :initiator_type
  end
end
