class StockAnalyze < ApplicationRecord
	belongs_to :stock
	belongs_to :analyze_type

	def self.generate_recommendation stock_id, analyze_type_id

		attributes = ["open", "high", "low", "close", "volume", "adjusted_close", "trend"]
		training = []
		decision, date = nil
		Stock.find(stock_id).stock_histories.each do |stock_history|

			if stock_history.next

				fact =
					case stock_history.next.trend
					when "up"
						"buy"
					when "down"
						"sell"
					else
						"hold"
					end

				training.push([
					stock_history[:open],
					stock_history[:high],
					stock_history[:low],
					stock_history[:close],
					stock_history[:volume],
					stock_history[:adjusted_close],
					stock_history[:trend] || "unchanged",
					fact
				])

			else

				dec_tree = DecisionTree::ID3Tree.new(
					attributes,
					training,
					'hold',
					open: :continuous,
					high: :continuous,
					low: :continuous,
					close: :continuous,
					volume: :continuous,
					adjusted_close: :continuous,
					trend: :discrete
				)
				dec_tree.train

				date = stock_history[:date]

				record = [
					stock_history[:open],
					stock_history[:high],
					stock_history[:low],
					stock_history[:close],
					stock_history[:volume],
					stock_history[:adjusted_close],
					stock_history[:trend]
				]

				decision = dec_tree.predict(record)

			end

		end

		unless StockAnalyze.find_by(stock_id: stock_id, date: date)
			StockAnalyze.create(stock_id: stock_id, analyze_type_id: analyze_type_id, suggestion: decision, date: date)
		end

	end

end
