$LOAD_PATH << File.expand_path('../app', __dir__)
$LOAD_PATH << File.expand_path('../lib', __dir__)

require 'authentication'
require 'jwt_middleware'
require 'models/user'
