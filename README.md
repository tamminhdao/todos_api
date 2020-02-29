# Todos API

This is a Ruby API backend written with Sinatra & ActiveRecord

## Setup

1. Clone the project
1. Run `bundle install`

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
