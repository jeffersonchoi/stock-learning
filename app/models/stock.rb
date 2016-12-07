class Stock < ApplicationRecord

	def self.search_quote symbol
		quote_type = YahooFinance::StandardQuote
		quote_symbols = symbol
		stock_info = {}
		YahooFinance::get_quotes( quote_type, quote_symbols ) do |qt|
			stock_info[:symbol] = qt.symbol
			stock_info[:name] = qt.name
			stock_info[:last_trade] = qt.lastTrade
			stock_info[:date] = qt.date
			stock_info[:time] = qt.time
			stock_info[:change] = qt.change
			stock_info[:change_points] = qt.changePoints
			stock_info[:change_percents] = qt.changePercent
			stock_info[:previous_close] = qt.previousClose
			stock_info[:open] = qt.open
			stock_info[:day_high] = qt.dayHigh
			stock_info[:day_low] = qt.dayLow
			stock_info[:volume] = qt.volume
			stock_info[:day_range] = qt.dayRange
			stock_info[:last_trade_with_time] = qt.lastTradeWithTime
			stock_info[:ticker_trend] = qt.tickerTrend
			stock_info[:average_daily_volume] = qt.averageDailyVolume
			stock_info[:bid] = qt.bid
			stock_info[:ask] = qt.ask
		end
		stock_info
	end

end
