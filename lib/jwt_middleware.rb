class JwtMiddleware
  OPEN_ROUTES = ['/signup', '/login', '/users/signup', '/users/login'].freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    return app.call(env) if OPEN_ROUTES.include?(env['PATH_INFO'])

    options = { algorithm: 'HS256', iss: ENV['JWT_ISSUER'] }
    bearer = env.fetch('HTTP_AUTHORIZATION', '').slice(7..-1)
    payload, _ = JWT.decode(bearer, ENV['JWT_SECRET'], true, options)

    env[:username] = payload.dig('user', 'username')

    app.call(env)

  rescue JWT::DecodeError
    [401, { 'Content-Type' => 'application/json' }, [{ 'error': 'A token must be passed.' }.to_json]]
  rescue JWT::ExpiredSignature
    [403, { 'Content-Type' => 'application/json' }, [{ 'error': 'The token has expired.' }.to_json]]
  rescue JWT::InvalidIssuerError
    [403, { 'Content-Type' => 'application/json' }, [{ 'error': 'The token does not have a valid issuer.' }.to_json]]
  rescue JWT::InvalidIatError
    [403, { 'Content-Type' => 'application/json' }, [{ 'error': 'The token does not have a valid "issued at" time.' }.to_json]]
  end

  private

  attr_reader :app
end
