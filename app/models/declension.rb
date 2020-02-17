class Declension < ApplicationRecord
  TYPES_OF_DECLINATIONS = {:"Р" => "genitive",
                           :"Д" => "dative" ,
                           :"Т" => "instrumental",
                           :"В" => "accusative",
                           :"П" => "prepositional"}

  belongs_to :person

  validates :declension_case,         presence: true
  validates :full_name,               format: { with: /\A[noe а-яё-]+\z/i }
  validates :first_name,              format: { with: /\A[а-яё]+\z/i }
  validates :last_name, :middle_name, format: { with: /\A[а-яё-]+\z/i }

  before_validation :set_full_name

  private

    def set_full_name
      self.full_name.delete!("none")
    end
end


