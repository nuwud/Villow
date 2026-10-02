Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    frontend_origin =
      ENV.fetch(
        'FRONTEND_ORIGIN',
        Rails.env.production? ? 'https://villow-fe.onrender.com' : 'http://localhost:3000'
      )

    origins frontend_origin

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: ['X-CSRF-Token'],
             credentials: true
  end
end
