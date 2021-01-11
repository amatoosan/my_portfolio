# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000/'
    #originsはstringしか受け付ないので、配列で複数ドメインを渡すときは以下のように文字列化する
    #origins ['https://a.rep-rikkyo.com', 'https://b.rep-rikkyo.com'].map(&:strip)

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
      #expose: %w[access-token uid client expiry]
  end
end
