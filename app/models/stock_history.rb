class StockHistory < ApplicationRecord

	belongs_to :stock

	def self.generate_history stock_id, symbol, date_range=180

		stock_history = {}
		count = 1

		YahooFinance::get_historical_quotes_days( symbol, date_range ) do |row|

			stock_history[count] = {}

			stock_history[count][:stock_id] = stock_id
			stock_history[count][:date] = row[0]
			stock_history[count][:open] = row[1]
			stock_history[count][:high] = row[2]
			stock_history[count][:low] = row[3]
			stock_history[count][:close] = row[4]
			stock_history[count][:volume] = row[5]
			stock_history[count][:adjusted_close] = row[6]

			count += 1

		end

		stock_history.to_a.reverse.to_h

	end

end
