class ChangeParentInDependent < ActiveRecord::Migration
  def change
    change_column :dependents, :parent, 'integer USING CAST(parent AS integer)'
  end
end
