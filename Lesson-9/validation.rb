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
    rescue ValidatorError
      false
    end

    protected

    def validate_presence(name)
      raise "Параметр nil или пуст" if name.nil? || name.empty?
    end

    def validate_format(name, format)
      raise "Параметр не соответствует формату" if name !~ format
    end

    def validate_type(name, type)
      raise "Параметр не верного типа" if name.class != type
    end
  end
end