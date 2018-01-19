class CreateCitas < ActiveRecord::Migration
  def change
    create_table :citas do |t|
      t.string :symptoms
      t.string :medicines
      t.string :cares
      t.string :annotations
    end
  end
end
