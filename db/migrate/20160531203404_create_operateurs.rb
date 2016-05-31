class CreateOperateurs < ActiveRecord::Migration
  def change
    create_table :operateurs do |t|
      t.string :nom
      t.geometry :zone, srid: 4326
      t.timestamps null: false
    end
  end
end
