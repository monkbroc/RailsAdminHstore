# Map HSTORE PostgreSQL field to boolean attributes
# true is stored as "1" and false as "0"
#
# Continue using store_accessor for string attributes
# See https://github.com/rails/rails/blob/master/activerecord/lib/active_record/store.rb
module StoreBoolean
  def store_accessor_boolean(store_attribute, *keys)
    options = keys.extract_options!

    keys = keys.flatten

    _store_accessors_module.module_eval do
      keys.each do |key|
        define_method("#{key}=") do |value|
          value = case value
                  when true then '1'
                  when false then '0'
                  else value
                  end
          write_store_attribute(store_attribute, key, value)
        end

        define_method(key) do
          val = read_store_attribute(store_attribute, key) || options[:default]
          %w(1 0).include?(val) ? (val == '1') : val
        end
      end
    end

    # assign new store attribute and create new hash to ensure that each class in the hierarchy
    # has its own hash of stored attributes.
    self.local_stored_attributes ||= {}
    self.local_stored_attributes[store_attribute] ||= []
    self.local_stored_attributes[store_attribute] |= keys
  end
end

