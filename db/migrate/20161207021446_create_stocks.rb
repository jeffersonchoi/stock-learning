class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.decimal :last_trade
      t.datetime :date
      t.datetime :time
      t.string :change
      t.decimal :change_points
      t.decimal :change_percents
      t.decimal :previous_close
      t.decimal :open
      t.decimal :day_high
      t.decimal :day_low
      t.decimal :volume
      t.string :day_range
      t.string :last_trade_with_time
      t.string :ticker_trend
      t.decimal :average_daily_volume
      t.decimal :bid
      t.decimal :ask

      t.timestamps
    end
  end
end
