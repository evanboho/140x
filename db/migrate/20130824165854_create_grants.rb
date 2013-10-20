class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.integer :granter_id
      t.integer :grantee_id
      t.datetime :starts
      t.datetime :ends

      t.timestamps
    end
    add_index :grants, :granter_id
    add_index :grants, :grantee_id
  end
end
