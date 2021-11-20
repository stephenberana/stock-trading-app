class Stock < ApplicationRecord
    belongs_to :trades
    has_many :users, through: :trades
end
