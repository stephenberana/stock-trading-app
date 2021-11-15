class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :trades
  has_many :stocks
  validates :approved, inclusion: { in: [true,false]}

  APPROVE_OPTIONS = [['True', true],
  ['False', false]
  ]
end
