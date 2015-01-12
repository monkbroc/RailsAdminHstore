Rails Admin and hstore attributes
=================================

If you are using an hstore field on your model to store a hash of
attributes and you want to see the attributes in Rails Admin, follow
these steps.

The hstore type requires PostgreSQL or another database that supports hstore.

[Live example](http://rails-admin-hstore.herokuapp.com)
-------------------------------------------------------

How to add hstore attributes
----------------------------

1. [Add the hstore extension with a migration](db/migrate/20150112154504_add_hstore_extension.rb)
2. [Add the hstore fields to your model with a migration](db/migrate/20150112154517_create_users.rb)
3. Add `store_accessor :customizations, :default_folder, :last_search` to
   [your model](app/models/user.rb)

4. (Optional) Hstore stores attributes as strings. If you want to store
   some boolean attributes in a hstore, you can use the `StoreBoolean`
   module.
```
  extend StoreBoolean
  store_accessor_boolean :preferences, :send_emails, :show_welcome, :default => false
```

How to show hstore attributes in Rails Admin
--------------------------------------------

1. [Add a Rails Admin config section to your model](app/models/user.rb)
```
  rails_admin do
    # Show the string hstore fields
    User.stored_attributes[:customizations].each do |field|
      configure field, :text
    end
  end
```
2. (Optional) Configure boolean attributes to show with checkboxes
```
  rails_admin do
    User.stored_attributes[:preferences].each do |field|
      configure field, :boolean
    end
  end
```

Boolean attributes
------------------

The boolean attributes are implemented in
[StoreBoolean](lib/store_boolean.rb). If you want to discuss the
implementation in there, open an issue.

