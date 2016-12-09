class CreateStockHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_histories do |t|
      t.references :stock, foreign_key: true
      t.datetime :date
      t.decimal :open
      t.decimal :high
      t.decimal :low
      t.decimal :close
      t.decimal :volume
      t.decimal :adjusted_close
      t.string :trend

      t.timestamps
    end
  end
end
