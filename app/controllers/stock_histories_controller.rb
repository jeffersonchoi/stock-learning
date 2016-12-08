class StockHistoriesController < ApplicationController

	def generate_history

		@stock_history = StockHistory.find_by_stock_id(params[:stock_id])

		day_range = if @stock_history.present?

			(Date.today - StockHistory.order(:date).last.date.to_date).to_i == 1 ? 0 : (Date.today - StockHistory.order(:date).last.date.to_date).to_i

		else
			10
		end

		stock_histories = StockHistory.generate_history params[:stock_id], params[:symbol].downcase, day_range

		stock_histories.each do |k, v|

			@stock_history = StockHistory.create(v)
			if StockHistory.count > 1
				puts @stock_history.id
				previous_stock_history_id = @stock_history[:id].to_i - 1
				previous_stock_close_price = StockHistory.find(previous_stock_history_id).adjusted_close
				case
				when @stock_history.adjusted_close > previous_stock_close_price
					@stock_history.trend = "up"
				when @stock_history.adjusted_close < previous_stock_close_price
					@stock_history.trend = "down"
				when @stock_history.adjusted_close == previous_stock_close_price
					@stock_history.trend = "unchange"
				end
			end
			@stock_history.save

		end

		redirect_back(fallback_location: stock_path(params[:symbol]))
	end

	protected

end
