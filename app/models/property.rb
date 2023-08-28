class Property < ApplicationRecord
  validates :name, presence: true
  has_many :stations, dependent: :destroy
  accepts_nested_attributes_for :stations,
                                allow_destroy: true,
                                reject_if: :all_blank
end