class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.string :name
      t.text :content
      t.datetime :date

      t.timestamps
    end
  end
end
