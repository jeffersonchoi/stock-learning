class StocksController < ApplicationController

	def index

		@stocks = Stock.all

		respond_to do |format|
			format.html
			format.json {render :json => @stocks}
		end

	end

	def show

		begin

			@stock = Stock.find_by_symbol(params[:symbol].downcase)

			unless @stock

				stock = Stock.search_quote params[:symbol].downcase

				raise ArgumentError if stock[:name] == "N/A"

				@stock = Stock.create(stock)

			end

			respond_to do |format|
				format.html
				format.json {render :json => @stock}
			end

		rescue ArgumentError

			flash[:error] = "Unable to find #{params[:symbol]}"
			redirect_to action: :index

		end

	end

	def quote_search

		begin

			@stock = Stock.find_by_symbol(params[:symbol].downcase)
			stock = Stock.search_quote params[:symbol].downcase

			raise ArgumentError if stock[:name] == "N/A"

			@stock.present? ? @stock.update(stock) : @stock = Stock.create(stock)

			redirect_to action: :show, symbol: @stock.symbol

		rescue ArgumentError

			flash[:error] = "Unable to find #{params[:symbol]}"
			redirect_to action: :index

		end

	end

end
