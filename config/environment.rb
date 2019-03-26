# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Remove broken inputs by field_with_errors
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  html_tag
end