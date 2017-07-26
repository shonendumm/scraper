class CreateDiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :diaries do |t|
      t.string :title, null: false
      t.string :link, null: false
      t.text :body
      t.string :date

      t.timestamps
    end
  end
end
