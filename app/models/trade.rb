class Trade < ApplicationRecord
    has_one :user
    belongs_to :stock

    accepts_nested_attributes_for :stock

    validates :quantity, numericality: { only_integer: true}

    def stock_attributes(stock)
        client = IEX::API::Client.new(
            publishable_token: 'pk_92611ab063e242c8b3ccbed009db8f65', 
            endpoint: 'https://sandbox.iexapis.com/v1'
        )

        self.stock = Stock.find_or_create_by(symbol: stock[:symbol])
        self.stock.price = client.price(stock[:symbol])
        self.stock.open_price = client.quote(stock[:symbol]).previous_close
        self.stock.update(stock)
    end
end
