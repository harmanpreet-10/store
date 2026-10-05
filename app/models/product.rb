class Product < ApplicationRecord
  include Notifiable

  has_one_attached :image
  has_rich_text :description

  has_many :subscribers, dependent: :destroy

  validates :name, presence: true

  validates :price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :inventory_count,
            numericality: { greater_than_or_equal_to: 0 }

  def in_stock?
    inventory_count.to_i > 0
  end

  def decrement_inventory!
    decrement!(:inventory_count) if in_stock?
  end
end
