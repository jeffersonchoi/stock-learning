class StocksController < ApplicationController

	def index

		@stocks = Stock.all

		respond_to do |format|
			format.html
			format.json {render :json => @stocks}
		end

	end

	def show

		@stock = Stock.find(params[:id])

		respond_to do |format|
			format.html
			format.json {render :json => @stock}
		end

	end

	def quote_search

		@stock = Stock.find_by_symbol(params[:symbol].downcase)
		stock = Stock.search_quote params[:symbol].downcase

		@stock.present? ? @stock.update(stock) : @stock = Stock.create(stock)

		redirect_to action: :show, id: @stock.id

	end

end
