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

		begin

			stock = Stock.search_quote params[:symbol].downcase

			if @stock

				@stock.update(stock)

			else

				raise ArgumentError, "Unable to find #{params[:symbol]}" if stock[:name] == "N/A"

				@stock = Stock.create(stock)

			end

			respond_to do |format|
				format.html
				format.json {render :json => @stock}
			end

		rescue ArgumentError => e

			flash[:error] = e
			redirect_to action: :index

		end

	end

	def quote_search

		begin

			stock = Stock.search_quote params[:symbol].downcase

			raise ArgumentError, "Unable to find #{params[:symbol]}" if stock[:name] == "N/A"

			@stock.present? ? @stock.update(stock) : @stock = Stock.create(stock)

			redirect_to action: :show, symbol: @stock.symbol

		rescue ArgumentError => e

			flash[:error] = e
			redirect_to action: :index

		end

	end

protected

	def find_stocks
		@stocks = Stock.all
	end

	def find_stock
		@stock = Stock.find_by_symbol(params[:symbol].downcase)
	end


end
