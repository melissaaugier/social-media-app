class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    
    has_many :posts, dependent: :destroy

    validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true, length: { minimum: 6 }
    validates :name, presence: true
    validates :last_name, presence: true
end
