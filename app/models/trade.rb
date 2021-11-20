class Trade < ApplicationRecord
    belongs_to :user
    has_one :stock


    accepts_nested_attributes_for :stock

    validates :quantity, numericality: :integer
    validates :purchase_date, presence: true

    def stock_attributes(stock)
        client = IEX::API::Client.new(
            publishable_token: 'pk_92611ab063e242c8b3ccbed009db8f65', 
            endpoint: 'https://sandbox.iexapis.com/v1'
        )

        self.stock = Stock.find_or_create_by(string: stock[:ticker])
        self.stock.price = client.price(stock[:ticker])
        self.stock.open_price = client.quote(stock[:ticker]).previous_close
        self.stock.update(stock)
        
    end

    # def deduct_from_balance
    #     balance - total_price
    # end
end
