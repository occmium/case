json.extract! person, :id, :first_name, :last_name, :middle_name, :sex, :full_name, :created_at, :updated_at
json.url person_url(person, format: :json)
