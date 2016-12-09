class CreateStockAnalyzes < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_analyzes do |t|
      t.references :stock, foreign_key: true
      t.references :analyze_type, foreign_key: true
      t.string :suggestion

      t.timestamps
    end
  end
end
