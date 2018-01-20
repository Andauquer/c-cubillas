class DropCitas < ActiveRecord::Migration
  def change
    drop_table :citas
  end
end
