require 'uri'
require 'net/http'
require 'rexml/document'

class DeclinationService
  LINK = "https://ws3.morpher.ru/russian/declension?s="
  DECLENSIONS = {:"Р" => "genitive",
                 :"Д" => "dative" ,
                 :"Т" => "instrumental",
                 :"В" => "accusative",
                 :"П" => "prepositional"}

  def self.run(person)
    uri = URI.parse(URI.escape(LINK + person.full_name))
    response = Net::HTTP.get_response(uri)
    doc = REXML::Document.new(response.body)

    declensions = []

    DECLENSIONS.each do |letter, declension_case|
      full_name = doc.get_text("//#{letter}").to_s

      last_name = full_name.split[0] == 'none' ? '' : full_name.split[0]
      middle_name = full_name.split[2] == 'none' ? '' : full_name.split[2]
      declined_names = {first_name:      full_name.split[1],
                        person_id:       person.id,
                        last_name:       last_name,
                        full_name:       full_name,
                        middle_name:     middle_name,
                        declension_case: declension_case}
      declensions << declined_names
    end

    declensions
  end
end
