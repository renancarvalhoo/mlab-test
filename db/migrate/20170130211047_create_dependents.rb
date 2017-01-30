class CreateDependents < ActiveRecord::Migration
  def change
    create_table :dependents do |t|
      t.text :name
      t.boolean :parent
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
