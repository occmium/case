class Person < ApplicationRecord
  has_many :declensions, dependent: :destroy

  validates :first_name, length: { in: 2..12 },
                         format: { with: /\A[а-яё]+\z/i }
  validates :last_name, length: { in: 2..32 },
                        format: { with: /\A[а-яё-]+\z/i },
                        if: :last_name?
  validates :middle_name, length: { in: 2..25 },
                          format: { with: /\A[а-яё-]+\z/i },
                          if: :middle_name?
  validates :sex, inclusion: { in: ['male', 'female', nil] }

  before_validation :set_full_name

  private

    def set_full_name
      self.full_name = "#{(last_name? ? last_name : "none")} " +
                       "#{first_name} " +
                       "#{(middle_name? ? middle_name : "none")}"
    end
end
