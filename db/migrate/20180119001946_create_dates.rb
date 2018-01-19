class CreateDates < ActiveRecord::Migration
  def change
    create_table :dates do |t|
      t.string :symptoms
      t.string :medicines
      t.string :cares
      t.string :annotations
      t.timestamps
    end
  end
end
