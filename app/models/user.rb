require 'store_boolean'

class User < ActiveRecord::Base
  # Add hstore field accessors
  store_accessor :customizations, :default_folder, :last_search

  # Optional: store boolean values in an hstore
  extend StoreBoolean
  store_accessor_boolean :preferences, :send_emails, :show_welcome, :default => false

  rails_admin do
    # Show the string hstore fields
    User.stored_attributes[:customizations].each do |field|
      configure field, :text
    end
    
    # Optional: show the boolean fields with a checkbox
    User.stored_attributes[:preferences].each do |field|
      configure field, :boolean
    end
  end
end
