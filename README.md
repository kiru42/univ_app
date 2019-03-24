# README

## Start Rails app

```bash
rails new PROJECT_NAME
cd PROJECT_NAME

# test if server is working
rails s
```

## Fixing sqlite version

- #<LoadError: Error loading the 'sqlite3' Active Record adapter. Missing a gem it depends on? can't activate sqlite3 (~> 1.3.6), already activated sqlite3-1.4.0. Make sure all dependencies are added to Gemfile.>

```ruby
gem 'sqlite3', '~> 1.3.6'
```
