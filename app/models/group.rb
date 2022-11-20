class Group < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  # has_one_attached :icon

  validates :name, presence: true, length: { maximum: 25 }
  validates :icon, presence: true

  def recent_transactions
     expenses.order('created_at Desc')
   end

  def total_expenses
    expenses.sum(:amount)
  end
end
