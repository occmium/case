require 'test_helper'

class DeclensionTest < ActiveSupport::TestCase
  def setup
    @person = Person.create(
      first_name: "Вася",
      last_name: "Васильев",
      middle_name: "Василич",
      sex: "male"
    )
    @declension = Declension.create(
      first_name: "Васе",
      last_name: "Васильеве",
      middle_name: "Василиче",
      full_name: "Васильеве Васе Василиче",
      declension_case: "prepositional",
      person_id: @person.id
    )
    @declension.reload
  end

  test "should be valid" do
    assert @declension.valid?
  end

  test "name should not be change" do
    @declension.first_name = "Nik"
    assert_equal "Nik", @declension.first_name
    @declension.reload
    assert @person.valid?
    assert_equal "Васе", @declension.first_name
  end
end
