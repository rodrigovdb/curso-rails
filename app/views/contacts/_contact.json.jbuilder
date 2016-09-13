json.extract! contact, :id, :employee_id, :contact_type_id, :phone_number, :created_at, :updated_at
json.url contact_url(contact, format: :json)