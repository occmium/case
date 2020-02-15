class Person < ApplicationRecord
  has_many :declensions, dependent: :destroy

  validates :first_name, presence: true
  validates :first_name, :last_name, :middle_name, format: { with: /\A[а-яё-]+\z/i }

  before_validation :set_full_name

  private

    def set_full_name
      self.full_name = "#{last_name} #{first_name} #{middle_name}"
    end
end
