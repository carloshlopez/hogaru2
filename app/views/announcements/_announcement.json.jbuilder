json.extract! announcement, :id, :text, :expiration_date, :user_id, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
