module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def attrs
      @attrs ||= []
    end

    def validate(name, type, *args)
      attrs << {name: name, type: type, args: args}
    end
  end

  module InstanceMethods
    def validate!
      return if self.class.attrs.nil?

      self.class.attrs.each do |attr|
        arg_name = instance_variable_get("@#{attr[:name]}")
        send("validate_#{attr[:type]}", arg_name, *attr[:args])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected
  end
end