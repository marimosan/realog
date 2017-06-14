class AddIndexLogDate < ActiveRecord::Migration[5.1]
  def change
    add_index :logs, :date
  end
end
