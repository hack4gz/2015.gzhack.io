class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :team
      t.string :title
      t.text :introduction
      t.text :attachments

      t.timestamps null: false
    end
  end
end
