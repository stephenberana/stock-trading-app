class Stock < ApplicationRecord
    has_many :trades
    has_many :users, through: :trades
end
