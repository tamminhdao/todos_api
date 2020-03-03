# Todo List

This is a Ruby API built with Sinatra & ActiveRecord, following [JWTs](https://jwt.io/introduction/) standard for authentication.

## Setup

1. Clone the project
1. Run `bundle install`

## Run the app

`rackup -p 3456`

## Testing

1. Run `bundle exec rspec -fd` for a single run.
1. Run `bundle exec guard` to start the test watcher.

## Linting

1. Run `rubocop --auto-correct`

## Database commands

Prefix migrate/rollback commands with RACK_ENV=development or RACK_ENV=test.

- Setup: `RACK_ENV=development bundle exec rake db:setup`
- Migrate: `bundle exec rake db:migrate`
- Rollback: `bundle exec rake db:rollback`
- Seed: `bundle exec rake db:seed`
- Make new migration: `bundle exec rake db:create_migration NAME=[INSERT NAME HERE]
