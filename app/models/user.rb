class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input full-width characters."}
    validates :name_reading, format: {with: /\A[ァ-ヶー]+\z/, message: "is invalid. Input full-width katakana characters."}
    validates :nickname, format: {with: /\A[a-z0-9]+\z/i, message: "is invalid. Input harf-width characters."}
  end
  
end
