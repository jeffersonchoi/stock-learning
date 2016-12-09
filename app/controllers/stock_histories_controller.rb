class StockHistoriesController < ApplicationController

	def generate_history

		@stock_history = StockHistory.where(stock_id: params[:stock_id]).order(date: :asc)

		day_range = if @stock_history.present?
			if (Date.today - @stock_history.order(:date).last.date.to_date).to_i == 1
				0
			else
				(Date.today - @stock_history.order(:date).last.date.to_date).to_i
			end
		else
			360
		end

		stock_histories = StockHistory.generate_history params[:stock_id], params[:symbol].downcase, day_range

		stock_histories.each do |k, v|

			if @stock_history.count == 0

				@new_stock_history = StockHistory.create(v)
				@stock_history = StockHistory.where(stock_id: params[:stock_id]).order(date: :asc)

			else


				@previous_stock_history_id = @stock_history.last.id.to_i

				next if v[:date].to_date == @stock_history.last.date.to_date


				@new_stock_history = StockHistory.new(v)

				previous_stock_close_price = StockHistory.find(@previous_stock_history_id).adjusted_close

				case
				when @new_stock_history.adjusted_close > previous_stock_close_price
					@new_stock_history.trend = "up"
				when @new_stock_history.adjusted_close < previous_stock_close_price
					@new_stock_history.trend = "down"
				when @new_stock_history.adjusted_close == previous_stock_close_price
					@new_stock_history.trend = "unchange"
				end

			end


			@new_stock_history.save

		end

		redirect_back(fallback_location: stock_path(params[:symbol]))
	end

	protected

end
