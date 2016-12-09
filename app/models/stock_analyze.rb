class StockAnalyze < ApplicationRecord
  belongs_to :stock
  belongs_to :analyze_type
end
