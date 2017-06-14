class ChangeDateToLog < ActiveRecord::Migration[5.1]
  def change
    change_column :logs, :date, :string
  end
end
