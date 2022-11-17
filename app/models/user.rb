# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses, dependent: :destroy, foreign_key: 'user_id'
  has_many :groups, dependent: :destroy, foreign_key: 'user_id'

  validates :name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
