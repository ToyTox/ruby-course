module Validation
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validate(attr_name, valid_type, **attrs)
      # ToDo write validate method
    end
  end
end