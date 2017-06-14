class CreateAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :auths do |t|
      t.string :pass

      t.timestamps
    end
  end
end
