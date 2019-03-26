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

## Adding root route

```ruby
Rails.application.routes.draw do
  root 'courses#index'
end
```

## Creating controller : app/controllers/courses_controller.rb

```ruby
class CoursesController < ApplicationController
  def index
  end
end
```

## Creating view : app/views/courses/index.html.erb

```html
<h1>Courses index</h1>
```

## Add more gems

```ruby
gem 'materialize-sass', '~> 1.0.0'
gem 'material_icons'
gem 'jquery-rails'
```

## Updating routes

```ruby
get 'courses/new', to: 'courses#new'
get 'about', to: 'pages#about'
```

## Show routes

```bash
rails routes
                   Prefix Verb URI Pattern                                                                              Controller#Action
                     root GET  /                                                                                        courses#index
              courses_new GET  /courses/new(.:format)                                                                   courses#new
                    about GET  /about(.:format)                                                                         pages#about
       rails_service_blob GET  /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
rails_blob_representation GET  /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
       rails_disk_service GET  /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
update_rails_disk_service PUT  /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
     rails_direct_uploads POST /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
```

## link_to in views

```erb
    <%= link_to 'Home', root_path  %>
    <%= link_to 'About', about_path  %>
    <%= link_to 'Add Course', courses_new_path  %>
```

## Migrations

```bash
# generate a migration file
rails generate migration create_courses
```

```ruby
class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :short_name
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
```

```bash
# Run Migration
rails db:migrate
```

## Using partials

```erb
<!DOCTYPE html>
<html>
  <head>
    <title>UnivApp</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render 'layouts/navigation' %>
    <main>
      <div class="container">
      <%= yield %>
      </div>
    </main>
    <%= render 'layouts/footer' %>
  </body>
</html>
```

## Email validation

```ruby
class User < ApplicationRecord
  # active record callback
  before_save { self.email = email.downcase }
  # has_many relationship
  has_many :articles, dependent: :destroy
  # uniqueness validation
  validates :username, presence: true, uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  # email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
  # Secure password
  has_secure_password
end
```

## Create Resource

### new form

```erb
<div class="container">
  <div class="row center sign-up-form">
    <div class="col s12 m12 l12">
      <div class="card-panel">
        <h3 class="header">Sign up !</h3>
        <div class="row">
          <%= form_for(@student, html: {class: "col s12"}) do |f| %>
            <div class="row">
              <div class="input-field col s12">
                <%= f.text_field :name, placeholder: "Enter your full name", autofocus: true %>
                <%= f.label :name %>
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <%= f.text_field :email, placeholder: "Enter your email address" %>
                <%= f.label :email %>
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <%= f.submit "Sign up", class: "btn orange waves-effect waves-light right" %>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </div>
  </div>
</div>
```

### create action

```ruby
  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:success] = "You have successfully signed up"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :email)
  end
```

## flash messages

### fade out flash message with jquery

```js
$('#fade-out-target').fadeOut(4000);
```

### add a flash message

```ruby
flash[:notice] = "You have successfully signed up"
```

### remove default behaviour of errors on forms' input

```ruby
# Add to config/environment.rb
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  html_tag
end
```

### Go through all forms errors

```erb
<% if @student.errors.any? %>
  <div class="container">
    <div class="row sign-up-form">
      <div class="col s12 m12 l12">
        <div class="card-panel red lighten-1">
          <span class="white-text">
            <strong><%= pluralize(@student.errors.count, "error") %>
            prohibited your profile from being created: </strong>
            <ul>
              <% @student.errors.full_messages.each do |message| %>
              <li><%= message %></li>
              <% end %>
            </ul>
          </span>
        </div>
      </div>
    </div>
  </div>
<% end %>
```

### Go through all flash messages

```erb
      <% flash.each do |key, message| %>
        <div class="container">
          <div class="row sign-up-form">
            <div class="col s12 m12 l12">
              <div class="card-panel green lighten-1" id="fade-out-target">
                <span class="white-text">
                  <%= message %>
                </span>
              </div>
            </div>
          </div>
        </div>
      <% end %>
```
