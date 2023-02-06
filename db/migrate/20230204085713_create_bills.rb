class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.references :biller, null: false, foreign_key: true
      t.references :entity, null: false, foreign_key: true
      t.integer :cadence
      t.string :account_no
      t.string :nickname

      t.timestamps
    end
  end
end
