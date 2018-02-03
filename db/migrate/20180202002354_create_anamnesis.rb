class CreateAnamnesis < ActiveRecord::Migration
  def change
    create_table :anamnesis do |t|
      t.string :sp
      t.string :hea
      t.string :fog
      t.string :ape
      t.string :apa
      t.string :afa
      t.string :sv
      t.string :pa
      t.string :fr
      t.string :p
      t.string :t
      t.string :fcyp
      t.string :tc
      t.string :orl
      t.string :cp
      t.string :abd
      t.string :ext
      t.string :pyf
      t.string :idx
      t.string :tx
      t.string :annotations
      t.string :patient_id
      t.timestamps
    end
  end
end
