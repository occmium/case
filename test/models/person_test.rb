require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = Person.create(
      first_name: "Вася",
      last_name: "Васильев",
      middle_name: "Василич",
      sex: "male"
    )
  end

  test "should be valid" do
    assert @person.valid?
  end

  test "name should not be too long" do
    @person.first_name = "Вася" * 4
    @person.last_name = "Одиннадцать" * 3
    @person.middle_name = "Тринадцать---" * 2
    assert_not @person.valid?
    assert_equal 3, @person.errors.count
  end

  test "name must change" do
    @person.update(first_name: "Николай",
                   last_name: "Николаев",
                   middle_name: "Николаевич")
    @person.reload
    assert_equal "Николаев Николай Николаевич", @person.full_name
  end

  test "name should not change" do
    @person.update(first_name: "Nik",
                   last_name: "Niko",
                   middle_name: "Nikola")
    @person.reload
    assert_not_equal "Niko Nik Nikola", @person.full_name
    assert_equal "Васильев Вася Василич", @person.full_name
    assert_equal 3, @person.errors.count
  end
end
# test "placeholders must be added to empty fields" do
#   @person.first_name = "Вася" * 3
#   @person.last_name = ""
#   @person.middle_name = ""
#   @person.reload
#   assert_equal "ВасяВасяВася", @person.first_name
#   assert_equal "none ВасяВасяВася none!", @person.full_name
#   assert @person.valid?
# end
