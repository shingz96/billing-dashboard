class AddMetadataToBills < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :metadata, :jsonb
    change_column_default :bills, :metadata, {}
  end
end
