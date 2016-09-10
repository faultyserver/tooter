class CreateToots < ActiveRecord::Migration[5.0]
  def change
    create_table :toots do |t|
      t.string      :body,    limit: 200,         null: false
      t.references  :author,  foreign_key: true,  null: false

      t.timestamps
    end
  end
end
