class CreateBillers < ActiveRecord::Migration[7.0]
  def change
    create_table :billers do |t|
      t.string :code, index: { unique: true }
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
