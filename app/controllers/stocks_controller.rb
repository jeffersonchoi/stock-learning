class StocksController < ApplicationController

	before_action :find_stocks
	before_action :find_stock, except: [:index]

	def index

		respond_to do |format|
			format.html
			format.json {render :json => @stocks}
		end

	end

	def show

		@stock_histories = @stock.stock_histories.order(date: :desc).all.paginate(page: params[:page], per_page: 10)

		respond_to do |format|
			format.html
			format.json {render :json => @stock}
		end

	end

	def quote_search

		redirect_to action: :show, symbol: @stock.symbol

	end

protected

	def find_stocks
		@stocks = Stock.all.order(name: :asc)
	end

	def find_stock

		@stock = Stock.find_by_symbol(params[:symbol].downcase)

		begin

			stock = Stock.search_quote params[:symbol].downcase

			if @stock

				@stock.update(stock)

			else

				raise ArgumentError, "Unable to find #{params[:symbol]}" if stock[:name] == "N/A"

				@stock = Stock.create(stock)

			end

		rescue ArgumentError => e

			flash[:error] = e
			redirect_to action: :index

		end


	end


end
