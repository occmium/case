require 'uri'
require 'net/http'
require 'rexml/document'

class DeclensionCreatorService
  LINK = "https://ws3.morpher.ru/russian/declension?s="

  def initialize(person)
    @person = person
    @person_id = person.id
    @full_name = person.full_name
    write_to_table_declensions
  end

  def write_to_table_declensions
    get_from_morfer(@full_name, @person_id).each do |param|
      declination_exist?(param) ? update_declination(param) : Declension.create(param)
    end
  end

  private

    def get_from_morfer(full_name, id)
      uri = URI.parse(URI.escape(LINK + full_name))
      response = Net::HTTP.get_response(uri)
      doc = REXML::Document.new(response.body)

      declensions = {:"Р" => "genitive",
                     :"Д" => "dative" ,
                     :"Т" => "instrumental",
                     :"В" => "accusative",
                     :"П" => "prepositional"}

      declensions_params = []
      declensions.each do |letter, word|
        full_name = doc.get_text("//#{letter}").to_s
        last_name = full_name.split[0] == 'none' ? '' : full_name.split[0]
        middle_name = full_name.split[2] == 'none' ? '' : full_name.split[2]
        declined_names = {person_id:       id,
                          full_name:       full_name.delete("none"),
                          last_name:       last_name,
                          first_name:      full_name.split[1],
                          middle_name:     middle_name,
                          declension_case: word}
        declensions_params << declined_names
      end
      declensions_params
    end

    def declination_exist?(param)
      @person.
        declensions.
        where(declension_case: param[:declension_case]).
        any?
    end

    def update_declination(param)
      @person.
        declensions.
        where(declension_case: param[:declension_case]).
        update(param)
    end
end
