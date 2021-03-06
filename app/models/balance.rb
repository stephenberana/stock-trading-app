class Balance < ApplicationRecord
    belongs_to :user

    def self.total_deposits
        sum(:deposit)
    end

    def self.total_withdrawals
        sum(:withdrawals)
    end

    def self.total_balance
        total_deposits - total_withdrawals
    end

    def self.deduct_from_balance(total_price)
        total_balance - total_price
        self.save
    end

    private

    def invalid_transaction
        return errors.add(:base, 'Insufficient balance for withdrawal.') if sum(:withdrawals) > sum(:deposit)
    end
end
