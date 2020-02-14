class CreateDeclensions < ActiveRecord::Migration[5.2]
  def change
    create_table :declensions do |t|
      t.string :declension_case
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :full_name
      t.references :person, foreign_key: true, null: false

      t.timestamps
    end
  end
end
