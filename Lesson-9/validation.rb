module Validation
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validate(attr_name, validate_type, **attrs)
      define_method()
      if validate_type == :presence
        raise TypeError, "#{attr_name} не может быть nil или пустой строкой" if attr_name == nil || ''
      end
      # ToDo write validate method
    end
  end
end